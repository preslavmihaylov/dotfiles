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

# Almost all the functions are taken from
# https://github.com/Valloric/ycmd/blob/master/ycmd/utils.py


import os
import subprocess
import sys
import time

# python3 compatibility
try:
    basestring
except NameError:
    basestring = str

try:
    import unittest2 as unittest
except ImportError:
    import unittest

py3only = unittest.skipIf(sys.version_info < (3, 0), "Python 3.x only test")
py2only = unittest.skipIf(sys.version_info >= (3, 0), "Python 2.x only test")


def python3():
    if on_windows():
        return os.path.abspath('/Python33/python')
    return 'python3'


def python():
    if sys.version_info < (3, 0) and 'CROSS_PYTHON_TESTS' in os.environ:
        return python3()
    return sys.executable


def with_jedihttp(setup, teardown):
    """Decorator which pass the return value of the setup function to the test
    function and to the teardown function."""
    def decorate(func):
        class Namespace:
            pass
        ns = Namespace()
        ns.jedihttp = None

        def test_wrapped():
            func(ns.jedihttp)

        def setup_wrapped():
            ns.jedihttp = setup()

        def teardown_wrapped():
            teardown(ns.jedihttp)

        test_wrapped.__name__ = func.__name__
        test_wrapped.setup = setup_wrapped
        test_wrapped.teardown = teardown_wrapped

        return test_wrapped
    return decorate


def fixture_filepath(*components):
    dir_of_current_script = os.path.dirname(os.path.abspath(__file__))
    return os.path.join(dir_of_current_script, 'fixtures', *components)


# Python 3 complains on the common open(path).read() idiom because the file
# doesn't get closed.
def read_file(filepath):
    with open(filepath) as f:
        return f.read()


# Creation flag to disable creating a console window on Windows. See
# https://msdn.microsoft.com/en-us/library/windows/desktop/ms684863.aspx
CREATE_NO_WINDOW = 0x08000000


def on_windows():
    return sys.platform == 'win32'


# Convert paths in arguments command to short path ones
def convert_args_to_short_path(args):
    def convert_if_path(arg):
        if os.path.exists(arg):
            return get_short_path_name(arg)
        return arg

    if isinstance(args, basestring):
        return convert_if_path(args)
    return [convert_if_path(arg) for arg in args]


# Get the Windows short path name.
# Based on http://stackoverflow.com/a/23598461/200291
def get_short_path_name(path):
    from ctypes import windll, wintypes, create_unicode_buffer

    # Set the GetShortPathNameW prototype
    _GetShortPathNameW = windll.kernel32.GetShortPathNameW
    _GetShortPathNameW.argtypes = [wintypes.LPCWSTR,
                                   wintypes.LPWSTR,
                                   wintypes.DWORD]
    _GetShortPathNameW.restype = wintypes.DWORD

    output_buf_size = 0

    while True:
        output_buf = create_unicode_buffer(output_buf_size)
        needed = _GetShortPathNameW(path, output_buf, output_buf_size)
        if output_buf_size >= needed:
            return output_buf.value
        output_buf_size = needed


# A wrapper for subprocess.Popen that fixes quirks on Windows.
def safe_popen(args, **kwargs):
    if on_windows():
        # We need this to start the server otherwise bad things happen.
        # See https://github.com/Valloric/YouCompleteMe/issues/637.
        if kwargs.get('stdin_windows') is subprocess.PIPE:
            kwargs['stdin'] = subprocess.PIPE
        # Do not create a console window
        kwargs['creationflags'] = CREATE_NO_WINDOW
        # Python 2 fails to spawn a process from a command containing unicode
        # characters on Windows.  See https://bugs.python.org/issue19264 and
        # http://bugs.python.org/issue1759845.
        # Since paths are likely to contains such characters, we convert them
        # to short ones to obtain paths with only ascii characters.
        args = convert_args_to_short_path(args)

    kwargs.pop('stdin_windows', None)
    return subprocess.Popen(args, **kwargs)


def process_is_running(handle):
    return handle.poll() is None


def wait_process_shutdown(handle, timeout=5):
    expiration = time.time() + timeout
    while True:
        if time.time() > expiration:
            raise RuntimeError('Waited for process to be shutdown for {0} '
                               'seconds, aborting.'.format(timeout))
        if not process_is_running(handle):
            return
        time.sleep(0.1)
