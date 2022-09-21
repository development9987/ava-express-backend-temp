const { authJwt } = require('../middleware');
const saleController = require('../controllers').sale;

module.exports = function (app) {
  app.get('/sale', [authJwt.verifyToken], saleController.get);
  app.post('/sale', [authJwt.verifyToken], saleController.add);
  app.post('/sale/by-customer/:id', [authJwt.verifyToken], saleController.getByCustomer);
  app.put('/sale', [authJwt.verifyToken], saleController.update);
  app.delete('/sale/:id', [authJwt.verifyToken], saleController.delete);
  app.post('/sale/add-sale-data', [authJwt.verifyToken], saleController.addSaleData);
};
