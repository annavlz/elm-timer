module.exports = function(grunt) {

  grunt.initConfig({
    elm: {
      compile: {
        files: {
          "main.js": ["Timer.elm"]
        }
      }
    },
    watch: {
      elm: {
        files: ["Main.elm", "Timer.elm", "Sessions.elm", "Todo.elm"],
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
