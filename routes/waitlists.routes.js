const { authJwt } = require('../middleware');
const waitlistsController = require('../controllers').waitlists;

module.exports = function (app) {
  app.get('/waitlists/:user_id', waitlistsController.getWaitlists);
  app.post('/waitlist', waitlistsController.addWaitlist);
  app.post('/waitlistViaPublic', waitlistsController.addWaitlistViaPublic);
  app.put('/waitlist', waitlistsController.updateWaitlist);
  app.put('/waitlistOrderNum', waitlistsController.updateWaitlistOrderNum);
  app.put('/servedtowaitlist', waitlistsController.servedToWaitlist);
  app.delete('/waitlist/:id', waitlistsController.deleteWaitlist);
  app.delete('/waitlistViaBublic/:id', waitlistsController.deleteWaitlist);
};
