const moment = require('moment');
const { packages } = require('../db/models');
const { ResponseFormat } = require('../core');

// const websetting = db.website_settings;

module.exports = {
async getPackages(req,res){

    await packages
    .findAll().then((res)=>{
        res.status(200).send({
            success: true,
            data: res,
          });
    })    

},



}
