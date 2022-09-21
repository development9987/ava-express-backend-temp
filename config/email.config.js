const dotenv = require('dotenv');
dotenv.config();

module.exports = {
  username: process.env.SENDGRID_USERNAME,
  password: process.env.SENDGRID_PASSWORD,
  apikey: process.env.SENDGRID_APIKEY,
};
