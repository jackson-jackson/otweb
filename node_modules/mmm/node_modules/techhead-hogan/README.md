## Hogan.js

[Hogan.js](http://twitter.github.com/hogan.js/) is a compiler for the
[Mustache](http://mustache.github.com/) templating language. For information
on Mustache, see the [manpage](http://mustache.github.com/mustache.5.html) and
the [spec](https://github.com/mustache/spec).

## What's New

This is the TECHHEAD fork of Hogan.js.  It adds helpers and a few more enhancements and bug fixes.

Here's what's inside: (see test/index.js for ...er, tests... and usage examples)

##### Fixes

+ fixed `Hogan.cacheKey()` to consider delimiters (and new options)
+ allow method call chaining using dot notation
+ fixed method calls to be called with the proper `this` (must use `fixMethodCalls` option)
+ partials have access to full context stack

##### Enhancements

+ shorthand section close tag
+ pass current context (top of context stack) to method calls
+ pass `index` and `array` to method calls made within a list iteration section
+ piped helpers

##### Examples

**Method call chaining**

```
var t = Hogan.compile("{{method1.method2.method3}}"),
    r = t.render({
      method1: function() {
        return {
          method2: function() {
            return {
              method3: function() {
                  return 'test';
              }
            };
          }
        };
      }
    });
// r === "test"
```

**Shorthand close tag and index passed to method call**

```
var t = Hogan.compile("{#names}{^first}, {/}{.}{/names}", { delimeters: '{ }' }),
    r = t.render({
      names: ['Larry', 'Moe', 'Curly'],
      first: function(val, index) {
        return (index === 0);
      }
    });
// r === "Larry, Moe, Curly"
```

**Piped helpers**

```
var t = Hogan.compile("{{ names | join | ucase }}", { fixMethodCalls:1, enableHelpers:1 }),
    r = t.render({
      names: ['Larry', 'Moe', 'Curly'],
      separator: ', ',
      join: function(arr) {
        return arr.join(this.separator);
      },
      ucase: function(val) {
        return (""+val).toUpperCase();
      }
    });
// r === "LARRY, MOE, CURLY"
```

## Authors

**Robert Sayre**

+ http://github.com/sayrer

**Jacob Thornton**

+ http://github.com/fat

**Jonathan Hawkes (this fork only)**

+ http://github.com/techhead

## License

Copyright 2012 Jonathan Hawkes

Copyright 2011 Twitter, Inc.

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
