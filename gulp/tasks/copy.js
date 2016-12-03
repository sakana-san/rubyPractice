var gulp = require('gulp');

gulp.task('copy', function() {
	return gulp.scr([
		'src/img/*.png',
		'src/img/*.jpg',
		'src/img/*.gif'
	], {base: 'src'})
	.pipe(gulp.dest('dist'));
});


