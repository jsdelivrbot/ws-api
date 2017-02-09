(function() {
  /*
   * @desc Loads all endpoints for the api found under the enpdpoint/ directory
   * AUTO Generated file.
   */

  /**
   * Loads API modules.
   */
  const api = require('./../api/main');

  /**
   * Exports function to initialize the API
   */
  api.lib.exports.publicize(module, function(app) {
    app.initializeApi(__dirname);
  });
})();
