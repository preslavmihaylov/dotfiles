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


import requests
import subprocess
import sys
import time
from jedihttp import hmaclib
from jedihttp.compatibility import decode_string
from jedihttp.tests import utils
from jedihttp.tests.utils import (process_is_running, py2only, read_file,
                                  wait_process_shutdown, with_jedihttp)
from os import path
from hamcrest import assert_that, equal_to

try:
    from http import client as httplib
except ImportError:
    import httplib


class HmacAuth(requests.auth.AuthBase):
    def __init__(self, secret):
        self._hmac_helper = hmaclib.JediHTTPHmacHelper(secret)

    def __call__(self, req):
        self._hmac_helper.sign_request_headers(req.headers,
                                               req.method,
                                               req.path_url,
                                               req.body)
        return req


PORT = 50000
SECRET = 'secret'
PATH_TO_JEDIHTTP = path.abspath(path.join(path.dirname(__file__),
                                          '..', '..', 'jedihttp.py'))


def wait_until_jedihttp_ready(timeout=5):
    expiration = time.time() + timeout
    while True:
        if time.time() > expiration:
            raise RuntimeError('Waited for JediHTTP to be ready '
                               'for {0} seconds, aborting.'.format(timeout))

        try:
            if requests.post('http://127.0.0.1:{0}/ready'.format(PORT),
                             auth=HmacAuth(SECRET)).json():
                return
        except requests.exceptions.ConnectionError:
            time.sleep(0.1)


def setup_jedihttp():
    hmac_file = hmaclib.temporary_hmac_secret_file(SECRET)
    command = [utils.python(),
               PATH_TO_JEDIHTTP,
               '--port', str(PORT),
               '--log', 'debug',
               '--hmac-file-secret', hmac_file]
    jedihttp = utils.safe_popen(command,
                                stdout=subprocess.PIPE,
                                stderr=subprocess.STDOUT)
    wait_until_jedihttp_ready()
    return jedihttp


def teardown_jedihttp(jedihttp):
    try:
        requests.post('http://127.0.0.1:{0}/shutdown'.format(PORT),
                      auth=HmacAuth(SECRET))
    except requests.exceptions.ConnectionError:
        pass

    try:
        wait_process_shutdown(jedihttp)
    except RuntimeError:
        jedihttp.terminate()

    stdout, _ = jedihttp.communicate()
    sys.stdout.write(decode_string(stdout))


@with_jedihttp(setup_jedihttp, teardown_jedihttp)
def test_client_request_without_parameters(jedihttp):
    response = requests.post('http://127.0.0.1:{0}/ready'.format(PORT),
                             auth=HmacAuth(SECRET))

    assert_that(response.status_code, equal_to(httplib.OK))

    hmachelper = hmaclib.JediHTTPHmacHelper(SECRET)
    assert_that(hmachelper.is_response_authenticated(response.headers,
                                                     response.content))


@with_jedihttp(setup_jedihttp, teardown_jedihttp)
def test_client_request_with_parameters(jedihttp):
    filepath = utils.fixture_filepath('goto.py')
    request_data = {
        'source': read_file(filepath),
        'line': 10,
        'col': 3,
        'source_path': filepath
    }

    response = requests.post(
        'http://127.0.0.1:{0}/gotodefinition'.format(PORT),
        json=request_data,
        auth=HmacAuth(SECRET))

    assert_that(response.status_code, equal_to(httplib.OK))

    hmachelper = hmaclib.JediHTTPHmacHelper(SECRET)
    assert_that(hmachelper.is_response_authenticated(response.headers,
                                                     response.content))


@with_jedihttp(setup_jedihttp, teardown_jedihttp)
def test_client_bad_request_with_parameters(jedihttp):
    filepath = utils.fixture_filepath('goto.py')
    request_data = {
        'source': read_file(filepath),
        'line': 100,
        'col': 1,
        'source_path': filepath
    }

    response = requests.post(
        'http://127.0.0.1:{0}/gotodefinition'.format(PORT),
        json=request_data,
        auth=HmacAuth(SECRET))

    assert_that(response.status_code, equal_to(httplib.INTERNAL_SERVER_ERROR))

    hmachelper = hmaclib.JediHTTPHmacHelper(SECRET)
    assert_that(hmachelper.is_response_authenticated(response.headers,
                                                     response.content))


@py2only
@with_jedihttp(setup_jedihttp, teardown_jedihttp)
def test_client_python3_specific_syntax_completion(jedihttp):
    filepath = utils.fixture_filepath('py3.py')
    request_data = {
        'source': read_file(filepath),
        'line': 19,
        'col': 11,
        'source_path': filepath
    }

    response = requests.post('http://127.0.0.1:{0}/completions'.format(PORT),
                             json=request_data,
                             auth=HmacAuth(SECRET))

    assert_that(response.status_code, equal_to(httplib.OK))

    hmachelper = hmaclib.JediHTTPHmacHelper(SECRET)
    assert_that(hmachelper.is_response_authenticated(response.headers,
                                                     response.content))


@with_jedihttp(setup_jedihttp, teardown_jedihttp)
def test_client_shutdown(jedihttp):
    response = requests.post('http://127.0.0.1:{0}/shutdown'.format(PORT),
                             auth=HmacAuth(SECRET))

    assert_that(response.status_code, equal_to(httplib.OK))
    assert_that(response.json(), equal_to(True))

    hmachelper = hmaclib.JediHTTPHmacHelper(SECRET)
    assert_that(hmachelper.is_response_authenticated(response.headers,
                                                     response.content))

    wait_process_shutdown(jedihttp)
    assert_that(process_is_running(jedihttp), equal_to(False))
