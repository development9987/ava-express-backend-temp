const { authJwt } = require('../middleware');
const appointmentController = require('../controllers').appointment;

module.exports = function (app) {
  app.get('/appointment/:appointment_key', appointmentController.verifyAppointmentKey);
  app.put('/appointment/:appointment_type', appointmentController.updateAppointment);

  app.post('/get-appointment-notification', authJwt.verifyToken, appointmentController.getAppointmentNotification);
};
