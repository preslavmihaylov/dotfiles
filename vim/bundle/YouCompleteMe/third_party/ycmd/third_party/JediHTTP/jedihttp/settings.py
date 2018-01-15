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

import jedi
import sys

# For efficiency, we store the default values of the global Jedi settings. See
# https://jedi.readthedocs.io/en/latest/docs/settings.html

auto_import_modules = jedi.settings.auto_import_modules
# The socket module uses setattr for several methods (connect, listen, etc.) on
# Python 2.
if sys.version_info < (3, 0):
    auto_import_modules.append('socket')

default_settings = {
    'case_insensitive_completion':
        jedi.settings.case_insensitive_completion,
    'add_bracket_after_function':
        jedi.settings.add_bracket_after_function,
    'no_completion_duplicates':
        jedi.settings.no_completion_duplicates,
    'cache_directory':
        jedi.settings.cache_directory,
    'use_filesystem_cache':
        jedi.settings.use_filesystem_cache,
    'fast_parser':
        jedi.settings.fast_parser,
    'dynamic_array_additions':
        jedi.settings.dynamic_array_additions,
    'dynamic_params':
        jedi.settings.dynamic_params,
    'dynamic_params_for_other_modules':
        jedi.settings.dynamic_params_for_other_modules,
    'additional_dynamic_modules':
        jedi.settings.additional_dynamic_modules,
    'auto_import_modules':
        auto_import_modules
}
