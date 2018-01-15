#     Copyright 2017 Cedraro Andrea <a.cedraro@gmail.com>
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

from jedihttp.compatibility import listvalues
from waitress.server import TcpWSGIServer
import select


class StoppableWSGIServer(TcpWSGIServer):
    """StoppableWSGIServer is a subclass of the TcpWSGIServer Waitress server
    with a shutdown method. It is based on StopableWSGIServer class from
    webtest: https://github.com/Pylons/webtest/blob/master/webtest/http.py"""

    shutdown_requested = False

    def start(self):
        """Wrapper of TcpWSGIServer run method. It prevents a traceback from
        asyncore."""

        # Message for compatibility with clients who expect the output from
        # waitress.serve here.
        print('serving on http://{0}:{1}'.format(self.effective_host,
                                                 self.effective_port))

        try:
            self.run()
        except select.error:
            if not self.shutdown_requested:
                raise

    def shutdown(self):
        """Properly shut down the server."""
        self.shutdown_requested = True
        # Shut down waitress threads.
        self.task_dispatcher.shutdown()
        # Close asyncore channels.
        # We can't use an iterator here because _map is modified while looping
        # through it.
        # NOTE: _map is an attribute from the asyncore.dispatcher class, which
        # is a base class of TcpWSGIServer. This may change in future versions
        # of waitress so extra care should be taken when updating waitress.
        for channel in listvalues(self._map):
            channel.close()
