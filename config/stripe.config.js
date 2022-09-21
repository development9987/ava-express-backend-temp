const dotenv = require('dotenv');

dotenv.config();

module.exports = {
  secret_key: process.env.STRIPE_SECRET_KEY,
};
