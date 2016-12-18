var webpack = require('webpack');
var gutil = require('gulp-util');
var merge = require('webpack-merge');

var isProduction = gutil.env.type === 'production' ? true : false;

//Todoオブジェクト指向にする
var config = {
	entry: {
		'common': [
			'./src/js/common/accordion.js',
			'./src/js/common/headerTracking.js',
		],
		'sub': [
			'./src/js/sub/objectInstance.js'
		],
		'app': [
			'./src/js/app/app.js'
		],
		vendor: [
			'jquery',
			'underscore',
			'backbone'
		]
	},
	output: {
		path: __dirname,
		filename: '[name].js'
	},
	externals: {
		$: 'jquery',
		jQuery: 'jquery',
		'window.jQuery': 'jquery',
		_: 'underscore',
		Backbone: 'backbone'
	},
	plugins: [
		// 指定した変数を他のモジュール内で使用できるようにする
		new webpack.ProvidePlugin({
			$: 'jquery',
			jQuery: 'jquery',
			'window.jQuery': 'jquery',
			_: 'underscore',
			Backbone: 'backbone'
		}),
		new webpack.optimize.CommonsChunkPlugin({
			name: 'vendor',
			filename: 'vendor.js',
			minChunks: Infinity
		})
	]
};

if (isProduction) {
	config = merge(config, {
		plugins: [
			//ファイルを細かく分析し、できるだけまとめてコードを圧縮
			new webpack.optimize.AggressiveMergingPlugin(),
			// compile時にuglifyでminimize
			new webpack.optimize.UglifyJsPlugin()
		]
	});
}
module.exports = config;
