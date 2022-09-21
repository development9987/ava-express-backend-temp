const { authJwt } = require('../middleware');
const analyticsController = require('../controllers').analytics;

module.exports = (app) => {
  app.get('/agency', authJwt.verifyToken, analyticsController.getAgencyData);
  app.get('/agency-info/:ID', authJwt.verifyToken, analyticsController.getAgencyInfo);
  app.put('/agency', authJwt.verifyToken, analyticsController.changeState);
};
