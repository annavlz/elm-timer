module.exports = function(grunt) {

  grunt.initConfig({
    elm: {
      compile: {
        files: {
          "elm.js": ["Timer.elm", "Sessions.elm"]
        }
      }
    },
    watch: {
      elm: {
        files: ["Timer.elm", "Sessions.elm"],
        tasks: ["elm"]
      }
    },
    clean: ["elm-stuff/build-artifacts"]
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-elm');

  grunt.registerTask('default', ['elm']);

};
