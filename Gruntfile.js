module.exports = function(grunt) {

  grunt.initConfig({
    elm: {
      compile: {
        files: {
          "elm.js": ["Timer.elm", "Timestamp.elm", "Transformer.elm"]
        }
      }
    },
    watch: {
      elm: {
        files: ["Timer.elm", "Timestamp.elm", "Transformer.elm"],
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
