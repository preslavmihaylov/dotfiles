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


from __future__ import absolute_import

from .utils import fixture_filepath, py3only, read_file
from webtest import TestApp
from jedihttp import handlers
from nose.tools import ok_
from hamcrest import (assert_that, only_contains, contains, contains_string,
                      contains_inanyorder, all_of, is_not, has_key, has_item,
                      has_items, has_entry, has_entries, equal_to, is_, empty)

import bottle
bottle.debug(True)


def completion_entry(name):
    return has_entry('name', name)


def valid_completions():
    return all_of(has_key('docstring'),
                  has_key('name'),
                  has_key('description'))


def test_healthy():
    app = TestApp(handlers.app)
    ok_(app.post('/healthy'))


def test_ready():
    app = TestApp(handlers.app)
    ok_(app.post('/ready'))


# XXX(vheon): test for unicode, specially for python3
# where encoding must be specified
def test_completion():
    app = TestApp(handlers.app)
    filepath = fixture_filepath('basic.py')
    request_data = {
        'source': read_file(filepath),
        'line': 7,
        'col': 2,
        'source_path': filepath
    }

    completions = app.post_json('/completions',
                                request_data).json['completions']

    assert_that(completions, only_contains(valid_completions()))
    assert_that(completions, has_items(completion_entry('a'),
                                       completion_entry('b')))


def test_good_gotodefinition():
    app = TestApp(handlers.app)
    filepath = fixture_filepath('goto.py')
    request_data = {
        'source': read_file(filepath),
        'line': 10,
        'col': 3,
        'source_path': filepath
    }

    definitions = app.post_json('/gotodefinition',
                                request_data).json['definitions']

    assert_that(definitions, contains_inanyorder(
        {
            'module_path': filepath,
            'name': 'f',
            'type': 'function',
            'in_builtin_module': False,
            'line': 1,
            'column': 4,
            'docstring': 'f()\n\nModule method docs\nAre '
                         'dedented, like you might expect',
            'description': 'def f',
            'full_name': '__main__.f',
            'is_keyword': False,
        },
        {
            'module_path': filepath,
            'name': 'C',
            'type': 'class',
            'in_builtin_module': False,
            'line': 6,
            'column': 6,
            'docstring': 'Class Documentation',
            'description': 'class C',
            'full_name': '__main__.C',
            'is_keyword': False
        }
    ))


def test_bad_gotodefinitions_blank_line():
    app = TestApp(handlers.app)
    filepath = fixture_filepath('goto.py')
    request_data = {
        'source': read_file(filepath),
        'line': 9,
        'col': 1,
        'source_path': filepath
    }
    definitions = app.post_json('/gotodefinition',
                                request_data).json['definitions']
    assert_that(definitions, is_(empty()))


def test_bad_gotodefinitions_not_on_valid_position():
    app = TestApp(handlers.app)
    filepath = fixture_filepath('goto.py')
    request_data = {
        'source': read_file(filepath),
        'line': 100,
        'col': 1,
        'source_path': filepath
    }
    response = app.post_json('/gotodefinition',
                             request_data,
                             expect_errors=True)
    assert_that(response.status_int, equal_to(500))


def test_good_gotoassignment():
    app = TestApp(handlers.app)
    filepath = fixture_filepath('goto.py')
    request_data = {
        'source': read_file(filepath),
        'line': 20,
        'col': 1,
        'source_path': filepath
    }

    definitions = app.post_json('/gotoassignment',
                                request_data).json['definitions']

    assert_that(definitions, contains({
        'module_path': filepath,
        'name': 'inception',
        'type': 'statement',
        'in_builtin_module': False,
        'line': 18,
        'column': 0,
        'docstring': '',
        'description': 'inception = _list[ 2 ]',
        'full_name': '__main__.inception',
        'is_keyword': False
    }))


def test_good_gotoassignment_do_not_follow_imports():
    app = TestApp(handlers.app)
    filepath = fixture_filepath('follow_imports', 'importer.py')
    request_data = {
        'source': read_file(filepath),
        'line': 3,
        'col': 9,
        'source_path': filepath
    }
    expected_definition = {
        'module_path': filepath,
        'name': 'imported_function',
        'type': 'function',
        'in_builtin_module': False,
        'line': 1,
        'column': 21,
        'docstring': 'imported_function()\n\n',
        'description': 'def imported_function',
        'full_name': 'imported.imported_function',
        'is_keyword': False
    }

    definitions = app.post_json('/gotoassignment',
                                request_data).json['definitions']

    assert_that(definitions, contains(expected_definition))

    request_data['follow_imports'] = False

    definitions = app.post_json('/gotoassignment',
                                request_data).json['definitions']

    assert_that(definitions, contains(expected_definition))


def test_good_gotoassignment_follow_imports():
    app = TestApp(handlers.app)
    importer_filepath = fixture_filepath('follow_imports', 'importer.py')
    imported_filepath = fixture_filepath('follow_imports', 'imported.py')
    request_data = {
        'source': read_file(importer_filepath),
        'line': 3,
        'col': 9,
        'source_path': importer_filepath,
        'follow_imports': True
    }

    definitions = app.post_json('/gotoassignment',
                                request_data).json['definitions']

    assert_that(definitions, contains({
        'module_path': imported_filepath,
        'name': 'imported_function',
        'type': 'function',
        'in_builtin_module': False,
        'line': 1,
        'column': 4,
        'docstring': 'imported_function()\n\n',
        'description': 'def imported_function',
        'full_name': 'imported.imported_function',
        'is_keyword': False
    }))


def test_usages():
    app = TestApp(handlers.app)
    filepath = fixture_filepath('usages.py')
    request_data = {
        'source': read_file(filepath),
        'line': 8,
        'col': 5,
        'source_path': filepath
    }

    definitions = app.post_json('/usages',
                                request_data).json['definitions']

    assert_that(definitions, contains_inanyorder(
        {
            'module_path': filepath,
            'name': 'f',
            'type': 'function',
            'in_builtin_module': False,
            'line': 1,
            'column': 4,
            'docstring': 'f()\n\nModule method docs\n'
                         'Are dedented, like you might expect',
            'description': 'def f',
            'full_name': '__main__.f',
            'is_keyword': False
        },
        {
            'module_path': filepath,
            'name': 'f',
            'type': 'statement',
            'in_builtin_module': False,
            'line': 6,
            'column': 4,
            'description': 'f',
            'docstring': '',
            'full_name': '__main__.f',
            'is_keyword': False
        },
        {
            'module_path': filepath,
            'name': 'f',
            'type': 'statement',
            'in_builtin_module': False,
            'line': 7,
            'column': 4,
            'description': 'f',
            'docstring': '',
            'full_name': '__main__.f',
            'is_keyword': False
        },
        {
            'module_path': filepath,
            'name': 'f',
            'type': 'statement',
            'in_builtin_module': False,
            'line': 8,
            'column': 4,
            'description': 'f',
            'docstring': '',
            'full_name': '__main__.f',
            'is_keyword': False
        }
    ))


def test_names():
    app = TestApp(handlers.app)
    filepath = fixture_filepath('names.py')
    request_data = {
        'source': read_file(filepath),
        'path': filepath,
        'all_scopes': False,
        'definitions': True,
        'references': False
    }

    definitions = app.post_json('/names', request_data).json['definitions']

    assert_that(definitions, contains_inanyorder(
        has_entries({
            'module_path': filepath,
            'name': 'os',
            'type': 'module',
            'in_builtin_module': False,
            'line': 1,
            'column': 7,
            'docstring': contains_string('OS routines'),
            'description': 'module os',
            'full_name': 'os',
            'is_keyword': False
        }),
        has_entries({
            'module_path': filepath,
            'name': 'CONSTANT',
            'type': 'statement',
            'in_builtin_module': False,
            'line': 3,
            'column': 0,
            'docstring': '',
            'description': 'CONSTANT = 1',
            'full_name': '__main__.CONSTANT',
            'is_keyword': False
        }),
        has_entries({
            'module_path': filepath,
            'name': 'test',
            'type': 'function',
            'in_builtin_module': False,
            'line': 5,
            'column': 4,
            'docstring': 'test()\n\n',
            'description': 'def test',
            'full_name': '__main__.test',
            'is_keyword': False
        })
    ))


def test_preload_module():
    app = TestApp(handlers.app)
    request_data = {
        'modules': ['os', 'sys']
    }

    ok_(app.post_json('/preload_module', request_data))


def test_usages_settings_additional_dynamic_modules():
    app = TestApp(handlers.app)
    file1 = fixture_filepath('module', 'some_module', 'file1.py')
    file2 = fixture_filepath('module', 'some_module', 'file2.py')
    main_file = fixture_filepath('module', 'main.py')
    request_data = {
        'source': read_file(file2),
        'line': 5,
        'col': 17,
        'source_path': file2,
        'settings': {
            'additional_dynamic_modules': [main_file]
        }
    }

    definitions = app.post_json('/usages',
                                request_data).json['definitions']

    assert_that(definitions, contains_inanyorder(
        has_entries({
            'module_path': file2,
            'name': 'FILE1_CONSTANT',
            'line': 5,
            'column': 11
        }),
        has_entries({
            'module_path': file2,
            'name': 'FILE1_CONSTANT',
            'line': 1,
            'column': 18
        }),
        has_entries({
            'module_path': file1,
            'name': 'FILE1_CONSTANT',
            'line': 5,
            'column': 11
        }),
        has_entries({
            'module_path': file1,
            'name': 'FILE1_CONSTANT',
            'line': 1,
            'column': 0
        }),
        has_entries({
            'module_path': main_file,
            'name': 'FILE1_CONSTANT',
            'line': 1,
            'column': 30
        }),
        has_entries({
            'module_path': main_file,
            'name': 'FILE1_CONSTANT',
            'line': 5,
            'column': 11
        })
    ))


@py3only
def test_py3():
    app = TestApp(handlers.app)
    filepath = fixture_filepath('py3.py')
    request_data = {
        'source': read_file(filepath),
        'line': 19,
        'col': 11,
        'source_path': filepath
    }

    completions = app.post_json('/completions',
                                request_data).json['completions']

    assert_that(completions, has_item(completion_entry('values')))
    assert_that(completions,
                is_not(has_item(completion_entry('itervalues'))))


def test_completion_socket_module():
    app = TestApp(handlers.app)
    filepath = fixture_filepath('socket_module.py')
    request_data = {
        'source': read_file(filepath),
        'line': 4,
        'col': 4,
        'source_path': filepath
    }

    completions = app.post_json('/completions',
                                request_data).json['completions']

    assert_that(completions, has_items(completion_entry('connect'),
                                       completion_entry('connect_ex')))
