var gulp = require('gulp');

var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var minifyCSS = require('gulp-minify-css');
var uglify = require('gulp-uglify');
var exec = require('gulp-exec');

var paths = {
    scripts: [
        'www/js/app/utils/*.coffee',
        'www/js/app/handler/*.coffee',
        'www/js/app/services/*.coffee',
        'www/js/app/controllers/*.coffee',
        'www/js/*.coffee'],
    css: ['www/css/*.css'],
    fonts: ['www/fonts/*.*'],
    dev: ['env/dev/**.coffee'],
    local: ['env/local/**.coffee'],
    prod: ['env/local/**.coffee']

};

var options = {
    silent: false
};

gulp.task('css', function () {
    var opts = {
        keepSpecialComments: 1,
        keepBreaks: true
    };

    gulp.src(paths.css)
        .pipe(minifyCSS(opts))
        .pipe(concat('all.min.css'))
        .pipe(gulp.dest('www/dist/css'))
});

gulp.task('scripts', function () {

    gulp.src(paths.scripts.concat(paths.dev))
        .pipe(coffee())
        .pipe(concat('all.min.js'))
        .pipe(gulp.dest('www/dist/js'));
});

gulp.task('uglify-scripts', function () {
    gulp.src(paths.scripts.concat(paths.prod))
        .pipe(coffee())
        .pipe(uglify({mangle: false}))
        .pipe(concat('all.min.js'))
        .pipe(gulp.dest('www/dist/js'));
});

gulp.task('fonts', function () {
    gulp.src(paths.fonts)
        .pipe(gulp.dest('www/dist/fonts'))
});

gulp.task('watch', function () {
    gulp.watch(paths.scripts, ['scripts']);
    gulp.watch(paths.css, ['css']);

});

gulp.task('server', function () {
    gulp.src('')
        .pipe(exec('http-server ./www/ -p 4000'), options);
});

gulp.task('coffee', function () {
    var coffeeStream = coffee({bare: true});

    coffeeStream.on('error', function (err) {
        console.log('[coffee-error]:', err)
    });

    gulp.src(paths.scripts.concat(paths.dev))
        .pipe(coffee())
        .pipe(gulp.dest('www/dist/js-app/'))

});

gulp.task('default', ['scripts', 'css', 'watch', 'fonts', 'server']);

gulp.task('dist', ['uglify-scripts', 'css', 'fonts']);

gulp.task('debug', ['scripts', 'css', 'fonts', 'watch']);
