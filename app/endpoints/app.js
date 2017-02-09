(function() {
  /*
   * File to interact with database.
   */
  const api = require('./../../api/main');
  const db = api.lib.database;
  const exporter= api.lib.exports;

  exporter.publicize(module, {

    /**
     * @param {Object} req - HTTP request
     * @param {!{
     *  send: !Function
     * }} res - HTTP response
     * @return {void}
     */
    world(req, res) {
      res.send('hello world');
    },

    /**
     * Modules endpoints
     * @return {Object} partial subset of the API's endpoints.
     */
    getEndPoints() {
      return {
        get: [
          {path: '/hello', handler: this.world.bind(this)},
        ],
      };
    }
  });
})();
