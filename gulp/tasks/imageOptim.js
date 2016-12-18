var gulp = require('gulp');
var gulpLoadPlugins = require('gulp-load-plugins');

var $ = gulpLoadPlugins({
	pattern: ['gulp-*', 'gulp.*'],
	replaceString: /\bgulp[\-.]/
});

gulp.task('imageOptim', function() {
	return gulp.src([
		'src/img/*.png',
		'src/img/*.jpg',
		'src/img/*.gif',
		'!src/img/sprite/*'
	])
	.pipe($.cache($.imagemin({
		progressive: true,
		interlaced: true
	})))
	.pipe(gulp.dest('dist/img/'));
});