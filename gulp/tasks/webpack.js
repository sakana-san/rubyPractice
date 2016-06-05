var gulp = require('gulp');
var webpack = require('webpack');
var webpackConfig = require('../webpack.config.js');
var gulpLoadPlugins = require('gulp-load-plugins');

var $ = gulpLoadPlugins({
	pattern: ['gulp-*', 'gulp.*'],
	replaceString: /\bgulp[\-.]/
});

//Todoオブジェクト指向にする
gulp.task('webpack', function() {
  // webpackConfigに対象ファイルが書かれているので適当なsrcでOK
	return gulp.src('./src/js/app/app.js')
	.pipe($.webpack(webpackConfig))
	.pipe(gulp.dest('dist/js/'));
});