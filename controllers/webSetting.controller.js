const moment = require('moment');
const db = require('../db/models');
const { ResponseFormat } = require('../core');

// const {websetting} = db;
const websetting = db.website_settings;

// const clientFields = db.client_fields;
// const waitlistSettings = db.waitlist_setting;
// const businessInfos = db.business_info;
// const localizationSettings = db.localization;
// const bookingSetting = db.booking_setting;
// const settingsService = require('../services/settings/settings.service');
// const emailService = require('../services/email/email.service');
// const stripeService = require('../services/stripe/stripe.service');

module.exports = {
async updateWebSetting(req,res){
    console.log(req.body,"aaaaaaaaaaaaaaaa");
    await websetting.update({
        logo:req.body.imageName,
         name:req.body.name,
         email:req.body.email,
         address:req.body.address
    }, { where: { id: 1} }).then((data)=>{
        
        res.status(200).send({
               success: true,
               result: data
        });
    })

},
async updateWebImageSetting(req,res){
    console.log(req.file,"aaaaaaaaaaaaaaaa");
    await websetting.update({
        // logo:req.file.originalname,
        //  name:req.body.name,
        //  email:req.body.email,
        //  address:req.body.address
    }, { where: { id: 1} }).then((data)=>{
        
        res.status(200).send({
               success: true,
               result: data
        });
    })

},
async getWebSetting(req,res){
    await websetting.findAll().then((data)=>{
        res.status(200).send({
            success: true,
            result: data
        });
    })

}


}
