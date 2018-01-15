# JediHTTP

[![Build Status](https://travis-ci.org/vheon/JediHTTP.svg?branch=master)](https://travis-ci.org/vheon/JediHTTP)
[![Build status](https://ci.appveyor.com/api/projects/status/28ebc35ocjk9eaew/branch/master?svg=true)](https://ci.appveyor.com/project/vheon/jedihttp/branch/master)


A simple http/json wrapper around [jedi][].

## Why

It's only purpose for me is to integrate it with [YouCompleteMe][] allowing to
run [jedi][] under python3 and get python3 completions, but that would not
exclude other uses :). At the moment not all the API It has been wrapped.

## Command-line

For starting the server, after you have cloned it somewhere:

```
python /path/to/JediHTTP/jedihttp.py [options]
```

### Options

#### `--host` ADDRESS

If not specified, 127.0.0.1 is used.

#### `--port` PORT

Listen on PORT. If not specified, will use any available port.

#### `--log` LEVEL

Set logging level to LEVEL. Available levels, from most verbose to least
verbose, are: `debug`, `info`, `warning`, `error`, and `critical`. Default value
is `info`.

#### `--hmac-secret-file` PATH

PATH is the path of a JSON file containing a key named `hmac_secret`. Its value
will be used as the secret for HMAC Auth and the file will be deleted as soon
as it's read.

## API

I thought JediHTTP as a simple wrapper around Jedi so its JSON API resembles
the original python one very much so for more information about what the
parameters are and what they represent look at the original docs
[jedi-plugin-api][].


### POST /healthy

Return a 200 status code if the server is up.

### POST /ready

Return a 200 status code if the server is up. Is the same as `/healthy`.

### POST /completions

Parameters:

```javascript
{
  "source": "def f():\n  pass",
  "line": 1,
  "col": 0,
  "path": "/home/user/code/src/file.py",
  "settings": {
    "add_bracket_after_function": true,
    ...
  } // Jedi settings. Optional.
}
```

Response:

```javascript
{
  "completions": [
    {
      "module_path": "/usr/lib/python2.7/os.py", // Shows the file path of a module.
      "name": "name", // Name of variable/function/class/module.
      "type": "type", // Type of the completion (module, class, instance, etc.)
      "line": 4,  // The line where the definition occurs (starting with 1).
      "column": 2, // The column where the definition occurs (starting with 0).
      "docstring": "A document string for this completion object.",
      "description": "A textual description of the object."
    },
    ...
  ]
}
```

### POST /gotodefinition

Parameters:

```javascript
{
  "source": "def f():\n  pass",
  "line": 1,
  "col": 0,
  "path": "/home/user/code/src/file.py",
  "settings": {} // Jedi settings. Optional.
}
```

Response:

```javascript
{
  "definitions": [
    {
      "module_path": "/usr/lib/python2.7/os.py", // Shows the file path of a module.
      "name": "name", // Name of variable/function/class/module.
      "type": "type", // Type of the completion (module, class, instance, etc.)
      "line": 3,  // The line where the definition occurs (starting with 1).
      "column": 1, // The column where the definition occurs (starting with 0).
      "in_builtin_module": false, // Whether this is a builtin module.
      "is_keyword": false,
      "docstring": "A document string for this Definition object.",
      "description": "A description of the Definition object.",
      "full_name": "Dot-separated path of this object."
    },
    ...
  ]
}
```

### POST /gotoassignment

Parameters:

```javascript
{
  "source": "def f():\n  pass",
  "line": 1,
  "col": 0,
  "path": "/home/user/code/src/file.py",
  "follow_imports": true, // Optional (default is false).
  "settings": {} // Jedi settings. Optional.
}
```

Response:

```javascript
{
  "definitions": [
    {
      "module_path": "/usr/lib/python2.7/os.py", // Shows the file path of a module.
      "name": "name", // Name of variable/function/class/module.
      "type": "type", // Type of the completion (module, class, instance, etc.)
      "line": 3,  // The line where the definition occurs (starting with 1).
      "column": 1 // The column where the definition occurs (starting with 0).
      "in_builtin_module": false, // Whether this is a builtin module.
      "is_keyword": false,
      "docstring": "A document string for this Definition object.",
      "description": "A description of the Definition object.",
      "full_name": "Dot-separated path of this object."
    },
    ...
  ]
}
```

### POST /usages

Parameters:

```javascript
{
  "source": "def f():\n  pass\n\na = f()\nb = f()",
  "line": 1,
  "col": 4,
  "path": "/home/user/code/src/file.py",
  "settings": {
    "additional_dynamic_modules": "/path/to/a/file.py"
  } // Jedi settings. Optional.
}
```

Response:

```javascript
{
  "definitions": [
    {
      "module_path": "/home/user/code/src/file.py",
      "name": "f",
      "type": "function",
      "in_builtin_module": false,
      "line": 1,
      "column": 4,
      "docstring": "",
      "description": "def f",
      "full_name": "file.f",
      "is_keyword": false
    },
    {
      "module_path": "/home/user/code/src/file.py",
      "name": "f",
      "type": "statement",
      "in_builtin_module": false,
      "line": 4,
      "column": 4,
      "docstring": "",
      "description": "a = f()",
      "full_name": "file",
      "is_keyword": false
    },
    {
      "module_path": "/home/user/code/src/file.py",
      "name": "f",
      "type": "statement",
      "in_builtin_module": false,
      "line": 5,
      "column": 4,
      "docstring": "",
      "description": "b = f()",
      "full_name": "file",
      "is_keyword": false
    }
  ]
}
```

### POST /names

Parameters:

```javascript
{
  "source": "import os\n\nCONSTANT = 1\n\ndef test():\n  pass",
  "path": "/home/user/code/src/file.py"
  "all_scopes": false, // Optional (default is false).
  "definitions": true, // Optional (default is true).
  "references": false, // Optional (default is false).
  "settings": {} // Jedi settings. Optional.
}
```

Response:

```javascript
{
  "definitions": [
    {
      "module_path": "/home/usr/code/src/file.py",
      "name": "os",
      "type": "import",
      "in_builtin_module": false,
      "line": 1,
      "column": 7,
      "docstring": "",
      "description": "import os",
      "full_name": "os",
      "is_keyword": false
    },
    {
      "module_path": "/home/usr/code/src/file.py",
      "name": "CONSTANT",
      "type": "statement",
      "in_builtin_module": false,
      "line": 3,
      "column": 0,
      "docstring": "",
      "description": "CONSTANT = 1",
      "full_name": "names",
      "is_keyword": false
    },
    {
      "module_path": "/home/usr/code/src/file.py",
      "name": "test",
      "type": "function",
      "in_builtin_module": false,
      "line": 5,
      "column": 4,
      "docstring": "test()\n\n",
      "description": "def test",
      "full_name": "names.test",
      "is_keyword": false
    }
  ]
}
```

### POST /preload_module

Parameters:

```javascript
{
  "modules": [ "numpy", ... ]
}
```

Response:

```javascript
true
```

### POST /shutdown

Shut down the server.

Response:

```javascript
true
```

### In case of errors

Response:

```javascript
{
  "exception": "ValueError"
  "message": "`column` parameter is not in a valid range.",
  "traceback": "Traceback ..."
}
```

status code: 500

## HMAC Auth

If the server is started with the `--hmac-file-secret` then the JediHTTP will
require every request and response has to be HMAC signed based on the secred
provided in the file putting the HMAC signature in a header called `x-jedihttp-hmac`

Assuming `||` stands for concatenation:

- requests signature: HMAC( HMAC( body ) || HMAC( http method ) || HMAC( request path ) ).
  For example, HMAC(HMAC('foo') || HMAC('GET') || HMAC('/healthy'))

- Responses: HMAC( body )


## Disclaimer

I'm not a python programmer but I'm using this to experiment with python a bit.

[jedi]: http://github.com/davidhalter/jedi
[jedi-plugin-api]: http://jedi.jedidjah.ch/en/latest/docs/plugin-api.html#module-jedi.api
[YouCompleteMe]: http://github.com/Valloric/YouCompleteMe
