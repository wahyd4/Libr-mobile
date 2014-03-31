# [gulp](https://github.com/wearefractal/gulp)-closure-compiler [![Build Status](https://secure.travis-ci.org/sindresorhus/gulp-closure-compiler.png?branch=master)](http://travis-ci.org/sindresorhus/gulp-closure-compiler)

> Minify JavaScript with [Closure Compiler](https://github.com/dcodeIO/ClosureCompiler.js)

*Issues with the output or Java should be reported on the Closure Compiler [issue tracker](https://github.com/dcodeIO/ClosureCompiler.js/issues).*


## Install

Install with [npm](https://npmjs.org/package/gulp-closure-compiler)

```
npm install --save-dev gulp-closure-compiler
```


## Example

```js
var gulp = require('gulp');
var closureCompiler = require('gulp-closure-compiler');

gulp.task('default', function () {
	gulp.src('src/*.js')
		.pipe(closureCompiler())
		.pipe(gulp.dest('dist'));
});
```


## API

### closureCompiler(options)

See the Closure Compiler [options](https://github.com/dcodeIO/ClosureCompiler.js#closurecompiler-api).


## License

MIT © [Sindre Sorhus](http://sindresorhus.com)
