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


import json
import hmac
import hashlib
import tempfile
from base64 import b64encode, b64decode
from jedihttp.compatibility import encode_string, decode_string, compare_digest


def temporary_hmac_secret_file(secret):
    """Helper function for passing the hmac secret when starting a JediHTTP
    server:

      hmac_file = temporary_hmac_secret_file('mysecret')
      jedihttp = subprocess.Popen(['python',
                                   'jedihttp',
                                   '--hmac-file-secret', hmac_file])

    The JediHTTP Server as soon as it reads the hmac secret will remove the
    file.
    """
    encoded_secret = decode_string(b64encode(encode_string(secret)))
    with tempfile.NamedTemporaryFile('w', delete=False) as hmac_file:
        json.dump({'hmac_secret': encoded_secret}, hmac_file)
    return hmac_file.name


_HMAC_HEADER = 'x-jedihttp-hmac'


class JediHTTPHmacHelper(object):
    """Helper class to correctly signing requests and validating responses when
    communicating with a JediHTTP server."""
    def __init__(self, secret):
        self._secret = encode_string(secret)

    def _has_header(self, headers):
        return _HMAC_HEADER in headers

    def _set_hmac_header(self, headers, hmac):
        headers[_HMAC_HEADER] = decode_string(b64encode(hmac))

    def _get_hmac_header(self, headers):
        return b64decode(headers[_HMAC_HEADER])

    def _hmac(self, content):
        return hmac.new(self._secret,
                        msg=encode_string(content),
                        digestmod=hashlib.sha256).digest()

    def _compute_request_hmac(self, method, path, body):
        if not body:
            body = ''
        return self._hmac(b''.join((self._hmac(method),
                                    self._hmac(path),
                                    self._hmac(body))))

    def sign_request_headers(self, headers, method, path, body):
        self._set_hmac_header(headers,
                              self._compute_request_hmac(method, path, body))

    def is_request_authenticated(self, headers, method, path, body):
        if not self._has_header(headers):
            return False

        return compare_digest(self._get_hmac_header(headers),
                              self._compute_request_hmac(method, path, body))

    def sign_response_headers(self, headers, body):
        self._set_hmac_header(headers, self._hmac(body))

    def is_response_authenticated(self, headers, content):
        if not self._has_header(headers):
            return False

        return compare_digest(self._get_hmac_header(headers),
                              self._hmac(content))
