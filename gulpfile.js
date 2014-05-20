var gulp = require('gulp');

var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var minifyCSS = require('gulp-minify-css');
var uglify = require('gulp-uglify');
var exec = require('gulp-exec');
var bower = require('gulp-bower');

var paths = {
    scripts: [
        'js/app/utils/*.coffee',
        'js/app/handler/*.coffee',
        'js/app/services/*.coffee',
        'js/app/directives/*.coffee',
        'js/app/controllers/*.coffee',
        'js/*.coffee'],
    css: ['css/*.css'],
    fonts: ['fonts/*.*'],
    dev: ['env/dev/**.coffee'],
    local: ['env/local/**.coffee'],
    prod: ['env/prod/**.coffee'],
    cordova: {
        js: ['js/**/*.js'],
        dist: ['dist/**'],
        img: ['img/**'],
        templates: ['templates/**'],
        assets: ['assets/**'],
        index: ['index.html']
    }
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
        .pipe(gulp.dest('dist/css'))
});

gulp.task('scripts', function () {

    gulp.src(paths.scripts.concat(paths.dev))
        .pipe(coffee())
        .pipe(concat('all.min.js'))
        .pipe(gulp.dest('dist/js'));
});

gulp.task('uglify-scripts', function () {
    gulp.src(paths.scripts.concat(paths.prod))
        .pipe(coffee())
        .pipe(uglify({mangle: false}))
        .pipe(concat('all.min.js'))
        .pipe(gulp.dest('dist/js'));
});

gulp.task('fonts', function () {
    gulp.src(paths.fonts)
        .pipe(gulp.dest('dist/fonts'))
});

gulp.task('watch', function () {
    gulp.watch(paths.scripts, ['scripts']);
    gulp.watch(paths.css, ['css']);

});

gulp.task('server', function () {
    gulp.src('')
        .pipe(exec('http-server ./ -p 4000'), options);
});

gulp.task('emulate-ios', function () {
    gulp.src('')
        .pipe(exec('cordova emulate ios'), options);
});

gulp.task('bower', function () {
    bower('./bower_components')
        .pipe(gulp.dest('assets'))
});

gulp.task('coffee', function () {
    var coffeeStream = coffee({bare: true});

    coffeeStream.on('error', function (err) {
        console.log('[coffee-error]:', err)
    });

    // gulp.src(paths.scripts.concat(paths.dev))
    //     .pipe(coffee())
    //     .pipe(gulp.dest('dist/js-app/'));
});

gulp.task('copy', function () {
    gulp.src(paths.cordova.js)
        .pipe(gulp.dest('./www/js'));

    gulp.src(paths.cordova.dist)
        .pipe(gulp.dest('./www/dist'));

    gulp.src(paths.cordova.img)
        .pipe(gulp.dest('./www/img'));

    gulp.src(paths.cordova.templates)
        .pipe(gulp.dest('./www/templates'));

    gulp.src(paths.cordova.index)
        .pipe(gulp.dest('./www'));
    gulp.src(paths.cordova.assets)
        .pipe(gulp.dest('./www/assets'));
})

gulp.task('default', ['bower', 'scripts', 'css', 'watch', 'fonts', 'server', 'copy']);

gulp.task('dist', ['bower', 'uglify-scripts', 'css', 'fonts', 'copy']);

gulp.task('debug', ['scripts', 'css', 'fonts', 'watch']);

gulp.task('emulate', ['copy', 'emulate-ios']);
