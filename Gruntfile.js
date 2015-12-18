module.exports = function(grunt) {

  grunt.initConfig({
    elm: {
      compile: {
        files: {
          "elm.js": ["Timer.elm", "Types.elm", "Sessions.elm", "Main.elm"]
        }
      }
    },
    watch: {
      elm: {
        files: ["Timer.elm", "Sessions.elm", "Main.elm", "Types.elm"],
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
