/*
 * Require gulp and all the modules
 */
var gulp = require('gulp'),
    sass = require('gulp-sass'),
    prefix = require('gulp-autoprefixer'),
    coffeelint = require('gulp-coffeelint'),
    jslint = require('gulp-jslint'),
    rename = require('gulp-rename'),
    cssmin = require('gulp-cssmin'),
    coffee = require('gulp-coffee'),
    uglify = require('gulp-uglify'),
    concat = require('gulp-concat'),
    gulpif = require('gulp-if'),
    watch = require('gulp-watch'),
    gutil = require('gulp-util');

/*
 * Paths
 */
var paths = {
  styles: ['./assets/stylesheets/sass/application.scss', './assets/stylesheets/sass/media-queries.scss'],
  scripts: ['./assets/javascripts/libs/*.js', './assets/javascripts/coffee/*.coffee'],
  coffee: ['./assets/javascripts/**/*.coffee'],
  js: ['./assets/javascripts/**/*.js']

};

/*
 * Gulp default task
 */
gulp.task('default', ['styles', 'scripts'], function() {
  // Watch style changes
  gulp.watch(paths.styles, ['styles']);

  // Watch script changes
  gulp.watch(paths.scripts, ['scripts', 'coffeelint']);
});

/*
 * Gulp tasks for stylesheets
 */
gulp.task('styles', function() {
  return gulp.src(paths.styles)
    // .pipe(sass({errLogToConsole: true, indentedSyntax: true}))
    .pipe(sass()
      .on('error', function(err) {
        sass.logError(err);
        this.emit('end');
      })
    )
    .pipe(prefix())
    .pipe(cssmin())
    .pipe(concat('application.min.css'))
    .pipe(gulp.dest('./assets/stylesheets'));
});

/*
 * Gulp task for javascripts
 */
gulp.task('scripts', function() {
  gulp.src(paths.scripts)
    .pipe(gulpif(/[.]coffee$/, coffee({bare: true}).on('error', gutil.log)))
    .pipe(uglify())
    // .pipe(rename({suffix: '.min'}))
    .pipe(concat('application.min.js'))
    .pipe(gulp.dest('./assets/javascripts'));
});

/*
 * Gulp task for linting coffee
 */
gulp.task('coffeelint', function() {
  gulp.src(paths.coffee)
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
});

/*
 * Gulp task for linting javascript
 */
gulp.task('jslint', function() {
  gulp.src(paths.js)
    .pipe(jslint())
    .pipe(jslint.reporter())
});