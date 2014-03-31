var gulp = require('gulp');

var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var minifyCSS = require('gulp-minify-css');
var uglify = require('gulp-uglify');

var paths = {
    scripts: ['www/js/app/utils/*.coffee',
        'www/js/app/handler/*.coffee',
        'www/js/app/services/*.coffee',
        'www/js/app/controllers/*.coffee',
        'www/js/*.coffee'],
    css: ['www/css/*.css'],
    fonts: ['www/fonts/*.*']

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
    gulp.src(paths.scripts)
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

gulp.task('default', ['scripts', 'css', 'watch','fonts']);

gulp.task('dist',['scripts','css','fonts']);
