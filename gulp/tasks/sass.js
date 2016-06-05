var gulp = require('gulp');
var gulpLoadPlugins = require('gulp-load-plugins');

var $ = gulpLoadPlugins({
	pattern: ['gulp-*', 'gulp.*'],
	replaceString: /\bgulp[\-.]/
});

gulp.task('sass', function() {
	return gulp.src(['src/sass/**/*.sass'])
		.pipe($.plumber({errorHandler: $.notify.onError('<%= error.message %>')}))
		.pipe($.sass())
		.pipe(gulp.dest('dist/css'));
});