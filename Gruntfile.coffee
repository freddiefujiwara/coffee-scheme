module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    simplemocha:
      options:
        globals: ['should','$','root']
        timeout: 3000
        ignoreLeaks: false
        ui: 'bdd'
        reporter: 'tap'
        compilers: 'coffee:coffee-script'
      all:
        src: 'test/**/*.coffee'

    watch:
      files: ['src/**/*.coffee','test/**/*.coffee']
      tasks: ['simplemocha']


  grunt.registerTask "default", ["simplemocha"]
