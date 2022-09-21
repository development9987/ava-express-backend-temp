const { authJwt } = require('../middleware');
const bookingsController = require('../controllers').bookings;

module.exports = function (app) {
  app.get(
    '/booking/:user_id',
    // [authJwt.verifyToken],
    bookingsController.getBooking
  );
  app.post('/booking',
  //  [authJwt.verifyToken],
    bookingsController.addBooking);
  app.post('/bookingViaPublic', bookingsController.addBookingViaPublic);
  app.put('/booking', 
  // [authJwt.verifyToken],
   bookingsController.updateBooking);
  app.post(
    '/booking/serveBooking/:id',
    // [authJwt.verifyToken],
    bookingsController.serveBooking
  );
  // app.put("/servedtowaitlist", [authJwt.verifyToken], bookingController.servedToWaitlist);
  app.delete(
    '/booking/:id',
    // [authJwt.verifyToken],
    bookingsController.deleteBooking
  );
  app.delete('/bookingViaBublic/:id', bookingsController.deleteBooking);
};
