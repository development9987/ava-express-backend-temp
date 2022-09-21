const multer = require('multer');

const upload = multer({ dest: 'uploads/images' });
const { verifySignUp, authJwt } = require('../middleware');
const authController = require('../controllers').auth;

module.exports = (app) => {
  app.post('/auth/signup',   // [verifySignUp.checkDuplicateEmail],
   authController.signup );
  app.post('/auth/signin', authController.signin);
  app.post('/auth/managersignup', //[verifySignUp.checkDuplicateEmail], 
  authController.managersignup);
  app.post('/auth/confirmbyid', authController.confirmbyid);
  app.get('/auth/businessByWaitlistUrl/:UrlNode', authController.getBusinessByWaitlist);
  app.get('/auth/businessByBookingUrl/:UrlNode', authController.getBusinessByBooking);
  app.get('/auth/business-by-appointment-key/:key', authController.getBusinessByAppointmentKey);
  app.post('/auth/resource_confirmbyid', authController.resource_confirmbyid);
  app.post('/auth/resourcesignup', //[verifySignUp.checkDuplicateEmail], 
  authController.resourcesignup);
  app.post('/auth/forgot', authController.forgot);
  app.get('/auth/token_validation', //[authJwt.verifyToken],
   authController.tokenValidation);
  app.post('/auth/reset', //[authJwt.verifyToken], 
  authController.resetPassword);
  app.post('/auth/me', //[authJwt.verifyToken], 
  authController.me);
  app.post('/auth/contact-us', authController.cotactToBusiness);
  app.put('/auth/profile/:type', //[authJwt.verifyToken], 
  upload.single('img_data'), authController.updateProfile);
  app.post('/auth/close-account', //[authJwt.verifyToken], 
  authController.closeAccount);
};
