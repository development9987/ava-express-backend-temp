const { authJwt } = require('../middleware');
const tasksController = require('../controllers').tasks;

module.exports = function (app) {
  app.get('/tasks/:user_id',
  //  [authJwt.verifyToken],
    tasksController.getTasks);
  app.post('/task',
  //  [authJwt.verifyToken], 
   tasksController.addTask);
  app.put('/task/', 
  // [authJwt.verifyToken], 
  tasksController.updateTask);
  app.delete('/task/:id', 
  // [authJwt.verifyToken], 
  tasksController.deleteTask);
  app.delete(
    '/task/deleteDescription/:id',
    // [authJwt.verifyToken],
    tasksController.deleteDescription
  );
  app.post(
    '/task/changeProgress',
    // [authJwt.verifyToken],
    tasksController.changeTaskProgress
  );
  app.get(
    '/task/reports/:description_id',
    // [authJwt.verifyToken],
    tasksController.getTaskReport
  );
  app.post('/task/addReport',
  //  [authJwt.verifyToken],
    tasksController.addReport);
};
