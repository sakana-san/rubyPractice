var gulp = require('gulp');
var gulpLoadPlugins = require('gulp-load-plugins');

var $ = gulpLoadPlugins({
	pattern: ['gulp-*', 'gulp.*'],
	replaceString: /\bgulp[\-.]/
});

gulp.task('lint', function() {
	return gulp.src([
		'src/js/**/*',
		'src/js/**/**/*',
	])
	.pipe($.plumber({errorHandler: $.notify.onError('<%= error.message %>')}))
	.pipe($.eslint())
	.pipe($.eslint.format())
	.pipe($.eslint.failOnError());
});