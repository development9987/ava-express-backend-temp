const moment = require('moment');
const db = require('../db/models');

module.exports = {
  async getResultQuery(query) {
    try {
      return await db.sequelize.query(query, {
        type: db.sequelize.QueryTypes.SELECT,
      });
    } catch (e) {
      console.log(e);
    }
  },

  dateExpress(date) {
    return moment(new Date(date)).utc().format('MM/DD/YYYY') === 'Invalid date'
      ? ''
      : moment(new Date(date)).utc().format('MM/DD/YYYY');
  },
};
