const packageController = require('../controllers').package;

module.exports = (app) => {
  app.get('/packages', packageController.getPackages);
  // app.get('/agency-info/:ID', packageController.getAgencyInfo);
  // app.put('/agency', packageController.changeState);
};
