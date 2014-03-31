'use strict';
var gutil = require('gulp-util');
var through = require('through2');
var ClosureCompiler = require('closurecompiler');

module.exports = function (options) {
	return through.obj(function (file, enc, cb) {
		if (file.isNull()) {
			this.push(file);
			return cb();
		}

		if (file.isStream()) {
			this.emit('error', new gutil.PluginError('gulp-closure-compiler', 'Streaming not supported'));
			return cb();
		}

		ClosureCompiler.compile(file.path, options, function (err, data) {
			if (err) {
				// it's only an error if no data. weird API...
				if (!data) {
					this.emit('error', new gutil.PluginError('gulp-closure-compiler', '\n' + err));
					return cb();
				}

				gutil.log('gulp-closure-compiler:\n' + gutil.colors.yellow(err));
			}

			file.contents = new Buffer(data);
			this.push(file);
			cb();
		}.bind(this));
	});
};
