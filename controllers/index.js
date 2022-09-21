const auth = require('./auth.controller');
const tasks = require('./tasks.controller');
const customers = require('./customers.controller');
const staff = require('./staff.controller');
const waitlists = require('./waitlists.controller');
const bookings = require('./bookings.controller');
const appointment = require('./appointment.controller');
const settings = require('./settings.controller');
const chat = require('./chat.controller');
const users=require('./users.controller')
const reports = require('./reports.controller');
const dashboard = require('./dashboard.controller');
const sale = require('./sale.controller');
const analytics = require('./analytics.controller');
const websetting =require('./webSetting.controller');
const package =require('./package.controller');

module.exports = {
  websetting,
  auth,
  tasks,
  users,
  customers,
  staff,
  waitlists,
  bookings,
  appointment,
  settings,
  chat,
  reports,
  dashboard,
  sale,
  analytics,
  package
};
