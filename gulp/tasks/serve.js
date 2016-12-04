var gulp = require('gulp');

gulp.task('serve', function() {
	//sass
	gulp.watch([
		'src/sass/**'
	], ['sass']);
	gulp.watch([
		'src/img/*.png',
		'src/img/*.jpg',
		'src/img/*.gif'
	], ['imageOptim']);
	gulp.watch([
		'src/img/sprite/*'
	], ['sprite']);
	gulp.watch([
		'src/js/**/*',
	],['webpack']);
});