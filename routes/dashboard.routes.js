const { authJwt } = require('../middleware');
const dashboardController = require('../controllers').dashboard;

module.exports = (app) => {
  app.get('/dashboard/personData/:id', [authJwt.verifyToken], dashboardController.getPersonData);
  app.get('/dashboard/taskData/:id', [authJwt.verifyToken], dashboardController.getTaskData);
  app.get('/dashboard/getDashboardData/:start/:end', [authJwt.verifyToken], dashboardController.dashboardData);
};
