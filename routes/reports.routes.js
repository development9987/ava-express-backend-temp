const { authJwt } = require('../middleware');
const reportController = require('../controllers').reports;

module.exports = (app) => {
  app.get('/report/get-report-data/:user_id/:type', authJwt.verifyToken, reportController.getReports);
  app.post('/report/get-sales-report-data', authJwt.verifyToken, reportController.getSalesData);
};
