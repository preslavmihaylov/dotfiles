#     Copyright 2015 Cedraro Andrea <a.cedraro@gmail.com>
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
#    limitations under the License.


from jedihttp import utils
utils.add_vendor_folder_to_sys_path()

import contextlib
import jedi
import logging
import json
import bottle
from bottle import response, request, Bottle
from jedihttp import hmaclib
from jedihttp.compatibility import iteritems
from jedihttp.settings import default_settings
from threading import Lock, Thread

try:
    import httplib
except ImportError:
    from http import client as httplib


# num bytes for the request body buffer; request.json only works if the request
# size is less than this
bottle.Request.MEMFILE_MAX = 1000 * 1024

logger = logging.getLogger(__name__)
app = Bottle(__name__)
wsgi_server = None

# Jedi is not thread safe.
jedi_lock = Lock()


@app.post('/healthy')
def healthy():
    logger.debug('received /healthy request')
    return _json_response(True)


@app.post('/ready')
def ready():
    logger.debug('received /ready request')
    return _json_response(True)


@app.post('/completions')
def completions():
    logger.debug('received /completions request')
    with jedi_lock:
        request_json = request.json
        with _custom_settings(request_json):
            script = _get_jedi_script(request_json)
            response = _format_completions(script.completions())
    return _json_response(response)


@app.post('/gotodefinition')
def gotodefinition():
    logger.debug('received /gotodefinition request')
    with jedi_lock:
        request_json = request.json
        with _custom_settings(request_json):
            script = _get_jedi_script(request_json)
            response = _format_definitions(script.goto_definitions())
    return _json_response(response)


@app.post('/gotoassignment')
def gotoassignments():
    logger.debug('received /gotoassignment request')
    with jedi_lock:
        request_json = request.json
        follow_imports = request_json.get('follow_imports', False)
        with _custom_settings(request_json):
            script = _get_jedi_script(request_json)
            response = _format_definitions(
                script.goto_assignments(follow_imports))
    return _json_response(response)


@app.post('/usages')
def usages():
    logger.debug('received /usages request')
    with jedi_lock:
        request_json = request.json
        with _custom_settings(request_json):
            script = _get_jedi_script(request_json)
            response = _format_definitions(script.usages())
    return _json_response(response)


@app.post('/names')
def names():
    logger.debug('received /names request')
    with jedi_lock:
        request_json = request.json
        with _custom_settings(request_json):
            definitions = _get_jedi_names(request_json)
            response = _format_definitions(definitions)
    return _json_response(response)


@app.post('/preload_module')
def preload_module():
    logger.debug('received /preload_module request')
    with jedi_lock:
        request_json = request.json
        with _custom_settings(request_json):
            jedi.preload_module(*request_json['modules'])
    return _json_response(True)


@app.post('/shutdown')
def shutdown():
    logger.info('received shutdown request')
    server_shutdown()
    return _json_response(True)


def server_shutdown():
    def terminate():
        if wsgi_server:
            wsgi_server.shutdown()

    # Use a separate thread to let the server send the response before shutting
    # down.
    terminator = Thread(target=terminate)
    terminator.daemon = True
    terminator.start()


def _format_completions(completions):
    return {
        'completions': [{
            'module_path': completion.module_path,
            'name':        completion.name,
            'type':        completion.type,
            'line':        completion.line,
            'column':      completion.column,
            'docstring':   completion.docstring(),
            'description': completion.description,
        } for completion in completions]
    }


def _format_definitions(definitions):
    return {
        'definitions': [{
            'module_path':       definition.module_path,
            'name':              definition.name,
            'type':              definition.type,
            'in_builtin_module': definition.in_builtin_module(),
            'line':              definition.line,
            'column':            definition.column,
            'docstring':         definition.docstring(),
            'description':       definition.description,
            'full_name':         definition.full_name,
            'is_keyword':        definition.is_keyword
        } for definition in definitions]
    }


def _get_jedi_script(request_data):
    return jedi.Script(request_data['source'],
                       request_data['line'],
                       request_data['col'],
                       request_data['source_path'])


def _get_jedi_names(request_data):
    return jedi.names(source=request_data['source'],
                      path=request_data['path'],
                      all_scopes=request_data.get('all_scopes', False),
                      definitions=request_data.get('definitions', True),
                      references=request_data.get('references', False))


def _set_jedi_settings(settings):
    for name, value in iteritems(settings):
        setattr(jedi.settings, name, value)


@contextlib.contextmanager
def _custom_settings(request_data):
    settings = request_data.get('settings')
    if not settings:
        yield
        return
    try:
        _set_jedi_settings(settings)
        yield
    finally:
        _set_jedi_settings(default_settings)


@app.error(httplib.INTERNAL_SERVER_ERROR)
def error_handler(httperror):
    body = _json_response({
        'exception': httperror.exception,
        'message': str(httperror.exception),
        'traceback': httperror.traceback
    })
    if 'jedihttp.hmac_secret' in app.config:
        hmac_secret = app.config['jedihttp.hmac_secret']
        hmachelper = hmaclib.JediHTTPHmacHelper(hmac_secret)
        hmachelper.sign_response_headers(response.headers, body)
    return body


def _json_response(data):
    response.content_type = 'application/json'
    return json.dumps(data, default=_serializer)


def _serializer(obj):
    try:
        serialized = obj.__dict__.copy()
        serialized['TYPE'] = type(obj).__name__
        return serialized
    except AttributeError:
        return str(obj)
