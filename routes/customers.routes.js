const { authJwt } = require('../middleware');
const customersController = require('../controllers').customers;

module.exports = function (app) {
  app.get('/customers',
  //  [authJwt.verifyToken],
    customersController.getallCustomers);
    app.get('/customers/:user_id',
    //  [authJwt.verifyToken],
      customersController.getCustomers);
    app.get(`/customerusers`,
    customersController.getCustomerUsers)
  app.post('/customer',
  //  [authJwt.verifyToken], 
   customersController.addCustomer);
  app.post('/customer/addWaitlists/:user_id',
  //  [authJwt.verifyToken],
    customersController.addWaitlistCustomer);
  app.put('/customer/:id',
  //  [authJwt.verifyToken], 
   customersController.updateCustomer);
  app.delete('/customer/:id',
  //  [authJwt.verifyToken],
    customersController.deleteCustomer);
  app.post('/customer/sendLinkToCustomer',
  //  [authJwt.verifyToken], 
   customersController.sendLinkToCustomer);
  app.post('/customer/getMessageHistory/:id',
  //  [authJwt.verifyToken],
    customersController.getMessageHistory);
  app.post('/customer/getEventHistory/:id', 
  // [authJwt.verifyToken], 
  customersController.getEventHistory);
  // app.post("/customers/delete", [authJwt.verifyToken], customersController.deleteCustomer.bind(null, io, usersMap));
};
