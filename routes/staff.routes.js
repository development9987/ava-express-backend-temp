const { authJwt } = require('../middleware');
const staffController = require('../controllers').staff;

module.exports = function (app) {
  app.get('/staff/:user_id',
  //  [authJwt.verifyToken],
    staffController.getStaff);
  app.post('/staff',
  //  [authJwt.verifyToken], 
   staffController.addStaff);
  // app.post('/staff/addWaitlists',
  // //  [authJwt.verifyToken],
  //   staffController.addWaitlistCustomer);
  app.put('/staff/:id',
  //  [authJwt.verifyToken], 
   staffController.updateStaff);
  app.delete('/staff/:id',
  //  [authJwt.verifyToken],
    staffController.deleteStaff);
  app.post('/staff/sendLinkToCustomer',
  //  [authJwt.verifyToken], 
   staffController.sendLinkToCustomer);
  app.post('/staff/getMessageHistory/:id',
  //  [authJwt.verifyToken],
    staffController.getMessageHistory);
  app.post('/staff/getEventHistory/:id', 
  // [authJwt.verifyToken], 
  staffController.getEventHistory);
  // app.post("/customers/delete", [authJwt.verifyToken], staffController.deleteCustomer.bind(null, io, usersMap));
};
