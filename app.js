var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

const swaggerUi = require('swagger-ui-express');
const openApiDocumentation = require('./openApiDocumentation');

require('dotenv').config();
var socketIo = require('socket.io');
const { createProxyMiddleware } = require('http-proxy-middleware');
const socketProxy = createProxyMiddleware('/socket.io', {
  target: 'http://localhost:8000',
  logLevel: 'debug',
});

var usersMap = {};
var app = express();
var io = socketIo();
var cors = require('cors');
// view engine setup
app.io = io;
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use('/uploads/images', express.static(path.join(__dirname, 'uploads/images')));
app.use(cookieParser());
app.use(cors());
// to sockets
app.use(socketProxy);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(openApiDocumentation));

app.get('/', (req, res) => {
  res.json({ message: 'API is working on...' });
});
app.get('/redirect', (req, res) => {
  return res.status(404).send({
    message: 'Redirect',
  });
});

app.use(function (req, res, next) {
  res.header('Access-Control-Allow-Headers', 'x-access-token, Origin, Content-Type, Accept');
  next();
});

require('./routes').authRoute(app); // auth
require('./routes').waitlistsRoute(app); // customers
require('./routes').customersRoute(app); // customers
require('./routes').usersRoute(app) // users
require('./routes').staffRoute(app); // staff
require('./routes').tasksRoute(app); // tasks
require('./routes').bookingsRoute(app); // booking
require('./routes').appointmentRoute(app); // appointment
require('./routes').settingsRoute(app); // settings
require('./routes').chatRoute(app, io, usersMap); // settings
require('./routes').reportRoute(app); // reports
require('./routes').dashboardRoute(app); // dashboard
require('./routes').saleRoute(app); // sale
require('./routes').analyticsRoute(app); // sale

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  // render the error page
  res.status(err.status || 500);
  res.send(err.message);
});

io.of('/api').on('connection', (socket) => {
  socket.on('addUser', (data) => {
    if (data && data.userId) {
      // console.log('got it data ' ,data);
      socket.join(data.businessID);
      if (!usersMap[data.companyId]) usersMap[data.companyId] = {};
      socket.userId = data.userId;
      socket.businessID = data.businessID;
      usersMap[data.userId] = socket.id;
      socket.to(socket.businessID).emit('newUserLogin', { id: data.userId });
    }
  });
  socket.on('disconnectUser', () => {
    socket.to(socket.businessID).emit('userDisconnect', { id: socket.userId });
    delete usersMap[socket.userId];
  });
  socket.on('disconnect', () => {
    socket.to(socket.businessID).emit('userDisconnect', { id: socket.userId });
    delete usersMap[socket.userId];
  });
});
var bookingController = require('./controllers/bookings.controller');
// bookingController.reminder();
var CronJob = require('cron').CronJob;
var reminder = new CronJob(
  '0 */5 * * * *',
  function () {
    bookingController.reminder();
  },
  null,
  true,
  'America/Los_Angeles',
);

module.exports = app;
