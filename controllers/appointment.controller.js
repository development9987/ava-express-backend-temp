const db = require('../db/models');
const sequelize = require('../db/models').Sequelize;
const Op = sequelize.Op;
const moment = require('moment');
// const users = db.users;
const bookings = db.bookings;
const customers = db.customers;
const bookingSettings = db.booking_setting;
const message_histories = db.message_histories;
const waitlist_settings = db.waitlist_setting;
const settingsService = require('../services/settings/settings.service');
// const customersService = require('../services/customers/customers.service');
const bookingService = require('../services/bookings/booking.service');
const twilioService = require('../services/twilio/twilio.service');
const emailService = require('../services/email/email.service');

module.exports = {
  async verifyAppointmentKey(req, res) {
    try {
      let appointmentData = await bookingService.validationAppointmentKey(req.params.appointment_key);
      // console.log(appointmentData);
      res.status(200).send({
        success: true,
        result: appointmentData,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async updateAppointment(req, res) {
    try {
      let dateTime = new Date();
      dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');

      await bookings.update(
        {
          appointment_type: req.params.appointment_type,
          appointment_time: dateTime,
        },
        {
          where: {
            id: req.body.id,
          },
        },
      );
      let booking = await bookings.findOne({
        where: {
          id: req.body.id,
        },
      });
      if (req.params.appointment_type == 3) {
        let customer = await customers.findOne({
          where: {
            id: booking.customer_id,
          },
        });
        let business = await settingsService.getBusiness(booking.user_id);
        let AlertSetting = await settingsService.getAlertSetting(booking.user_id);
        let bookingSetting = await bookingSettings.findOne({
          where: {
            user_id: booking.user_id,
          },
        });
        let result = AlertSetting.find((e) => e.key == 'BookingCancelled');
        let sendingData = JSON.parse(result.data_field);
        let message = sendingData['sms_template'];
        message = message.replace(/{name}/g, customer.name);
        message = message.replace(/{business}/g, business['business_name']);
        message = message.replace(
          /{link}/g,
          `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
        );
        message = message.replace(/{time}/g, moment(booking.startDate).format('h:mm a'));
        message = message.replace(/{date}/g, moment(booking.date).format('MMM Do'));
        message = message.replace(/{hour}/g, moment(booking.startDate).format('h:mm a'));
        message = message.replace(/{cancelUrl}/, `${req.headers.referer}appointment/${booking.appointment_key}`);
        if (sendingData['SendAsSMS']) {
          var is_success = await twilioService.sendSMS(customer.phone, message);
          await message_histories.create({
            customer_id: customer.id,
            business_id: business.ID,
            message: message,
            is_success: is_success,
            send_at: dateTime,
            sending_type: 'SMS',
            message_type: 'customerSendLink',
          });
        }
        //Send Email
        if (sendingData['SendAsEmail']) {
          let subject = sendingData['subject'] ? sendingData['subject'] : '';
          let text = sendingData['email_template'] ? sendingData['email_template'] : '';
          subject = subject.replace(/{name}/g, customer.name);
          subject = subject.replace(/{business}/g, business['business_name']);
          subject = subject.replace(
            /{link}/g,
            `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
          );
          subject = subject.replace(/{time}/g, moment(booking.startDate).format('h:mm a'));
          subject = subject.replace(/{date}/g, moment(booking.date).format('MMM Do'));
          subject = subject.replace(/{hour}/g, moment(booking.startDate).format('h:mm a'));
          subject = subject.replace(/{cancelUrl}/, `${req.headers.referer}appointment/${booking.appointment_key}`);
          text = text.replace(/{name}/g, customer.name);
          text = text.replace(/{business}/g, business['business_name']);
          text = text.replace(
            /{link}/g,
            `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
          );
          text = text.replace(/{time}/g, moment(booking.startDate).format('h:mm a'));
          text = text.replace(/{date}/g, moment(booking.date).format('MMM Do'));
          text = text.replace(/{hour}/g, moment(booking.startDate).format('h:mm a'));
          text = text.replace(/{cancelUrl}/, `${req.headers.referer}appointment/${booking.appointment_key}`);
          let emailData = {
            template: 'alerts',
            message: {
              from: 'info@avamgt.com',
              to: customer.email,
            },
            locals: {
              subject: subject ? subject : 'avamgt.com',
              message: text,
            },
          };
          var is_success = await emailService.sendEmail(emailData);

          await message_histories.create({
            customer_id: customer.id,
            business_id: business.ID,
            subject: subject ? subject : 'avamgt.com',
            message: text,
            is_success: is_success,
            send_at: dateTime,
            sending_type: 'Email',
            message_type: 'customerSendLink',
          });
        }
      }

      let appointmentData = await bookingService.getBookingDataById(req.body.id);

      res.status(200).send({
        success: true,
        result: appointmentData,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async getAppointmentNotification(req, res) {
    try {
      let adminId = await settingsService.getAdminId(req.user.id);
      var startDate = moment().format('YYYY-MM-DD H:mm');
      var endDate = moment().add(30, 'minute').format('YYYY-MM-DD H:mm');
      let result = await bookings.findAll({
        where: {
          user_id: adminId,
          serve_time: {
            [Op.eq]: null,
          },
          done_time: {
            [Op.eq]: null,
          },
          appointment_time: {
            [Op.between]: [new Date(startDate), new Date(endDate)],
          },
        },
      });
      res.status(200).send({
        success: true,
        result: result,
      });
    } catch (e) {
      console.log(e);
    }
  },
};
