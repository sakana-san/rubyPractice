#Gruntfile.coffee
module.exports = (grunt) ->
	#config
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		paths:
			srcDir: 'src/'
			distDir: 'dist/'

		compass:
			dev:
				options:
					httpPath: '/'
					cssDir: '<%= paths.srcDir %>css/'
					sassDir: '<%= paths.srcDir %>sass/'
					imagesDir: '<%= paths.srcDir %>img/'
					javascriptDir: '<%= paths.srcDir %>js/'
					outputStyle: 'expanded'
					noLineComments: true
					environment: 'development'
		clean:
			deleteDir:
				src: '<%= paths.distDir %>'
		copy:
			html:
				expand: true
				cwd: './'
				src: '*.html'
				dest: '<%= paths.distDir %>'
			css:
				expand: true
				cwd: '<%= paths.srcDir %>'
				src: 'css/**'
				dest: '<%= paths.distDir %>'
			images:
				expand: true
				cwd: '<%= paths.srcDir %>'
				src: ['img/*.png','img/*.jpg']
				dest: '<%= paths.distDir %>'
			js:
				expand: true
				cwd: '<%= paths.srcDir %>'
				src: ['js/common.js','js/sub/**']
				dest: '<%= paths.distDir %>'

		sprite:
			all:
				src: '<%= paths.srcDir %>img/sprite/*.png'
				dest: '<%= paths.distDir %>img/sprite.png'
				destCss: '<%= paths.srcDir %>sass/sprite/_sprite.scss'
				algorithm: 'binary-tree'
				padding: 5
		cssmin:
			files:
				expand: true
				cwd: '<%= paths.srcDir %>css/'
				src: 'common.css'
				dest: '<%= paths.distDir %>css/'
				ext: ".css"
		concat: 
			files: 
				src: '<%= paths.srcDir %>js/concat/**'
				dest: '<%= paths.distDir %>js/common.js'
		uglify: 
			files:
				expand: true
				cwd: '<%= paths.distDir %>'
				src: ['js/common.js','js/sub/*.js']
				dest: '<%= paths.distDir %>'
		watch:
			css:
				files: ['<%= paths.srcDir %>sass/**','<%= paths.srcDir %>css/common.css']
				tasks: ['compass:dev','cssmin']
			js:
				files: ['<%= paths.srcDir %>js/concat/**','<%= paths.srcDir %>js/sub/**']
				tasks: ['concat','copy:js']

	#plugin
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-compass'
	grunt.loadNpmTasks 'grunt-spritesmith'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-copy' 
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-uglify'

	#tasks
	grunt.registerTask 'default',['concat','copy:js','sprite','copy:images','watch']
	grunt.registerTask 'build',['clean:deleteDir','copy:html','copy:css','copy:images','copy:js','sprite','cssmin','concat','uglify']
