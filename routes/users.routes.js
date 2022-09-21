const { authJwt } = require('../middleware');
const userController = require('../controllers').users;

module.exports = function (app) {
  app.get('/users/:user_id',
  //  [authJwt.verifyToken],
    userController.getUsers);
  app.get('/allUsers',
      userController.getAllUsers);

  app.post('/user',
  //  [authJwt.verifyToken], 
   userController.addUser);
  app.post('/user/addWaitlists/:user_id',
  //  [authJwt.verifyToken],
    userController.addWaitlistUser);
  app.put('/user/:id',
  //  [authJwt.verifyToken], 
   userController.updateUser);
  app.delete('/user/:id',
  //  [authJwt.verifyToken],
    userController.deleteUser);
  app.post('/user/sendLinkToUser',
  //  [authJwt.verifyToken], 
   userController.sendLinkToUser);
  app.post('/user/getMessageHistory/:id',
  //  [authJwt.verifyToken],
    userController.getMessageHistory);
  app.post('/user/getEventHistory/:id', 
  // [authJwt.verifyToken], 
  userController.getEventHistory);
  // app.post("/users/delete", [authJwt.verifyToken], userController.deleteUser.bind(null, io, usersMap));
};
