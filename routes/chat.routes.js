const { authJwt } = require('../middleware');
const chatController = require('../controllers').chat;

module.exports = (app, io, usersMap) => {
  app.get('/chat/users/:id',
  // [authJwt.verifyToken],
    chatController.getUsers.bind(null, io, usersMap));
  app.get('/chat/:selectedId/:id',
//   [authJwt.verifyToken],
    chatController.getConversationData);
  app.post('/chat',
 //  [authJwt.verifyToken],
    chatController.addChatData.bind(null, io, usersMap));
  app.put('/chat',
 //  [authJwt.verifyToken],
    chatController.updateChatData);
  app.delete('/chat/:id',
  // [authJwt.verifyToken], 
   chatController.deleteChatData);
  app.post('/readMessage',
  // [authJwt.verifyToken],
    chatController.readMessage.bind(null, io, usersMap));
};
