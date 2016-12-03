var gulp = require('gulp');
var gulpLoadPlugins = require('gulp-load-plugins');

var $ = gulpLoadPlugins({
	pattern: ['gulp-*', 'gulp.*'],
	replaceString: /\bgulp[\-.]/
});

gulp.task('sprite', function() {
	var spriteData = gulp.src(['src/img/sprite/*.png'])
	.pipe($.plumber({errorHandler: $.notify.onError('<%= error.message %>')}))
	.pipe($.spritesmith({
		imgName: 'sprite.png',
		impPath: '../img/sprite.png' + new Date().getTime(),
		cssName: '_sprite.scss',
		cssFormat: 'scss',
		padding: 5
	}));
	spriteData.img.pipe(gulp.dest('dist/img'));
	return spriteData.css.pipe(gulp.dest('src/sass/sprite'));
});