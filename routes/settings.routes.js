// file upload

const { authJwt } = require('../middleware');
const settingsController = require('../controllers').settings;
const websettingsController = require('../controllers').websetting;

const multer = require('multer');
const path=require('path')
// const upload = multer({ dest: 'uploads/images' });

const storage=multer.diskStorage({
  destination: function(req,file,cb){
    console.log("first1");

    cb(null,'uploads/images')
    console.log("first2");
  } ,
  filename:function(req,file,cb){
    console.log(file);

    cb(null,file.fieldname+"-"+Date.now()+path.extname(file.originalname))
    console.log("first2");
  }
})

const upload=multer({
  storage:storage,
  limits:1000000,
  fileFilter:function(req,file,cb){
    checkFileType(file,cb);
  }
})

function checkFileType(file,cb){
  console.log("first3");

      const fileTypes=/jpeg|jpg|png|gif|/;
      const extname=fileTypes.test(path.extname(file.originalname).toLowerCase())
      const mimetype=fileTypes.test(file.mimetype);
      
      if(mimetype && extname){
        console.log("first4");

        return cb(null,true);
      }
      else{
        console.log("first5");

        return cb("File Invalid")
      }
}



// console.log(upload.toString);

module.exports = (app) => {
  app.post('/admin/websetting',
  //  [authJwt.verifyToken], 
   websettingsController.updateWebSetting);
   app.post('/admin/websetting/image',upload.single('newFile'),
  //  [authJwt.verifyToken], 
   websettingsController.updateWebImageSetting);
   app.get('/admin/websetting',
  //  [authJwt.verifyToken], 
   websettingsController.getWebSetting);
  // resource routes
  app.get('/resource/:id',
  //  [authJwt.verifyToken], 
   settingsController.getResources);
  app.post('/resource/getResourceByResource/:user_id',
  //  [authJwt.verifyToken],
    settingsController.getResourceByResource);
  app.post('/resource', 
  // [authJwt.verifyToken],
  //  upload.single('img_data'),
    settingsController.addResource);
  app.put('/resource/:id',
  //  [authJwt.verifyToken],
    // upload.single('img_data'),
     settingsController.updateResource);
  app.post('/resource/available',
  //  [authJwt.verifyToken],
    settingsController.updateResourceAvailable);
  app.delete('/resource/:id',
  //  [authJwt.verifyToken],
    settingsController.deleteResource);
  // manager routes
  app.get('/manager/:id',
  //  [authJwt.verifyToken],
    settingsController.getManager);
  app.post('/manager/:id', 
  // [authJwt.verifyToken],
   settingsController.addManager);
  app.put('/manager', 
  // [authJwt.verifyToken],
   settingsController.updateManager);
  app.delete('/manager/:id', 
  // [authJwt.verifyToken], 
  settingsController.deleteManager);
  // service routes
  app.get('/service/:id', 
  // [authJwt.verifyToken], 
  settingsController.getServices);
  app.post('/service/:id',
  //  [authJwt.verifyToken],
    // upload.single('img_data'),
     settingsController.addService);
  app.put('/service/:id', 
  // [authJwt.verifyToken],
  //  upload.single('img_data'),
    settingsController.updateService);
  app.delete('/service/:id', 
  // [authJwt.verifyToken], 
  settingsController.deleteService);
  // waitlist routes
  app.post('/waitlist/clientFieldAdd',
  //  [authJwt.verifyToken],
    settingsController.addClientField);
  app.post('/waitlist/clientFieldUpdate', 
  // [authJwt.verifyToken], 
  settingsController.updateClientField);
  app.get('/waitlist/clientField/:user_id', //[authJwt.verifyToken],
   settingsController.getClientField);
  app.post('/waitlist/setenableField/:id', 
  // [authJwt.verifyToken], 
  settingsController.enableField);
  app.delete('/waitlist/deleteClientField/:id', 
  // [authJwt.verifyToken], 
  settingsController.deleteClientField);

  app.get('/waitlist/getWaitListSettings/:id', //[authJwt.verifyToken], 
  settingsController.getWaitListSettings);
  app.post('/waitlist/updateWaitListSettings/', 
  // [authJwt.verifyToken],
   settingsController.updateWaitListSettings);
  app.post('/waitlist/ResetSettings/', //[authJwt.verifyToken], 
  settingsController.ResetSettings);
  app.post('/waitlist/ClearData/', //[authJwt.verifyToken],
   settingsController.ClearData);
  app.post('/waitlist/DeleteWaitList/', //[authJwt.verifyToken],
   settingsController.DeleteWaitList);

  app.get('/booking/getBookingSettings/:id', //[authJwt.verifyToken],
   settingsController.getBookingSettings);
  app.post('/booking/getFilterBookingSettings',
  //  //[authJwt.verifyToken],

    settingsController.getFilterBookingSettings);
  app.post('/booking/updateBookingSettings/', //[authJwt.verifyToken],
   settingsController.updateBookingSettings);

  app.get('/alert/getAlertSetting/:id', //[authJwt.verifyToken],
   settingsController.getAlertSetting);
  app.post('/alert/updateAlertSetting/', //[authJwt.verifyToken],
   settingsController.updateAlertSetting);
  app.post('/alert/add-message-template/', //[authJwt.verifyToken],
   settingsController.addMessageTemplate);
  app.post('/alert/update-message-template/', //[authJwt.verifyToken],
   settingsController.updateMessageTemplate);
  app.post('/alert/get-message-template/', //[authJwt.verifyToken],
   settingsController.getMessageTemplate);

  // app.get('/info/:businessId', [authJwt.verifyToken], settingsController.getBusinessInfo);
  app.get('/BusinessInfo/getBusinessSetting/:id', //[authJwt.verifyToken], 
  settingsController.getBusinessInfo);
  // app.post(
  //   '/info/:type',
  //   // [authJwt.verifyToken],
    // upload.single('img_data'),

  //   settingsController.updateBusinessInfoSetting,
  // );
  app.post('/BusinessInfo/updateBusinessInfoSettings', //[authJwt.verifyToken],
   settingsController.updateBusinessInfoSetting);
  app.get(
    '/Localization/getLocalizationSettings/:id',
    // [authJwt.verifyToken],
    settingsController.getLocalizationSetting,
  );
  app.post(
    '/Localization/updateLocalizationSettings/',
    // [authJwt.verifyToken],
    settingsController.updateLocalizationSetting,
  );

  // stripe
  app.post('/subscription/create-checkout-session',
  //  [authJwt.verifyToken],
    settingsController.createCheckoutSession);
  app.post('/subscription/get-payment-history', 
  // [authJwt.verifyToken], 
  settingsController.getPaymentHistory);
  app.post('/subscription/buy-plan',
  //  [authJwt.verifyToken], 
   settingsController.buyPlan);
  app.post('/subscription/get-membership', 
  // [authJwt.verifyToken], 
  settingsController.getMembership);
  app.post('/subscription/create-subscription',
  //  [authJwt.verifyToken],
    settingsController.createSubscription);
};
