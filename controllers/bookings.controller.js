const db = require('../db/models');
const moment = require('moment');
const { Op } = require('sequelize');
// const randomWords = require('random-words');
const users = db.users;
const bookings = db.bookings;
const message_histories = db.message_histories;
const waitlists = db.waitlists;
const customers = db.customers;
const bookingSettings = db.booking_setting;

const customersService = require('../services/customers/customers.service');
const bookingService = require('../services/bookings/booking.service');
const twilioService = require('../services/twilio/twilio.service');
const emailService = require('../services/email/email.service');
const settingsService = require('../services/settings/settings.service');
const app = require('../app');

module.exports = {
  async getBooking(req, res) {
    try {
      let bookingData = await bookingService.getBookingDataByUser(req.params.user_id);
      let customerData = await customersService.getCustomerByUser(req.params.user_id);
      res.status(200).send({
        success: true,
        result: {
          booking_data: bookingData,
          customer_data: customerData,
        },
      });
    } catch (e) {
      console.log(e);
    }
  },

  async addBooking(req, res) {
    // console.log(req.body);
    let admin_id = await settingsService.getAdminId(req.body.user_id);
    const AlertSetting = await settingsService.getAlertSetting(admin_id);
    let business = await settingsService.getBusiness(admin_id);
    let currentUser = await settingsService.getUser(req.body.user_id);
    let dateTime = new Date();
    let bookingSetting = await bookingSettings.findOne({
      where: {
        user_id: admin_id,
      },
    });
    try {
      let newCustomer = null;
      if (!req.body.customer_id) {
        newCustomer = await customersService.createNewCustomer({
          ...req.body,
          user_id: req.body.user_id,
        });
      }
      let random_key = bookingService.generateKey(8);

      let booking = await bookings.create({
        user_id: admin_id,
        customer_id: req.body.customer_id ? req.body.customer_id : newCustomer.id,
        service_id: JSON.stringify(req.body.service_id),
        title: req.body.title,
        note: req.body.note,
        resource: req.body.resource,
        startDate: req.body.startDate,
        endDate: req.body.endDate,
        appointment_key: random_key,
        appointment_time: dateTime,
      });

      let result = AlertSetting.find((e) => e.key == 'BookingConfirmation');
      let sendingData = JSON.parse(result.data_field);

      new Promise(async () => {
        //send SMS
        let message = sendingData['sms_template'];
        message = message.replace(/{name}/g, req.body.name);
        message = message.replace(/{business}/g, business['business_name']);
        message = message.replace(
          /{link}/g,
          `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
        );
        message = message.replace(/{user}/g, currentUser.username);
        message = message.replace(/{time}/g, moment(req.body.startDate).format('h:mm a'));
        message = message.replace(/{date}/g, moment(req.body.date).format('MMM Do'));
        message = message.replace(/{hour}/g, moment(req.body.startDate).format('h:mm a'));
        message = message.replace(/{cancelUrl}/, `${req.headers.referer}appointment/${booking.appointment_key}`);
        if (sendingData['SendAsSMS']) {
          var is_success = await twilioService.sendSMS(req.body.phone, message);
          await message_histories.create({
            customer_id: req.body.customer_id,
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
          let text = sendingData['email_template'];
          subject = subject.replace(/{name}/g, req.body.name);
          subject = subject.replace(/{user}/g, currentUser.username);
          subject = subject.replace(/{business}/g, business['business_name']);
          subject = subject.replace(
            /{link}/g,
            `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
          );
          subject = subject.replace(/{time}/g, moment(req.body.startDate).format('h:mm a'));
          subject = subject.replace(/{date}/g, moment(req.body.date).format('MMM Do'));
          subject = subject.replace(/{hour}/g, moment(req.body.startDate).format('h:mm a'));
          subject = subject.replace(/{cancelUrl}/, `${req.headers.referer}appointment/${booking.appointment_key}`);
          text = text.replace(/{name}/g, req.body.name);
          text = text.replace(/{user}/g, currentUser.username);
          text = text.replace(/{business}/g, business['business_name']);
          text = text.replace(
            /{link}/g,
            `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
          );
          text = text.replace(/{time}/g, moment(req.body.startDate).format('h:mm a'));
          text = text.replace(/{date}/g, moment(req.body.date).format('MMM Do'));
          text = text.replace(/{hour}/g, moment(req.body.startDate).format('h:mm a'));
          text = text.replace(/{cancelUrl}/, `${req.headers.referer}appointment/${booking.appointment_key}`);
          let emailData = {
            template: 'alerts',
            message: {
              from: 'info@avamgt.com',
              to: req.body.email,
            },
            locals: {
              subject: subject ? subject : 'avamgt.com',
              message: text,
            },
          };
          var is_success = await emailService.sendEmail(emailData);

          await message_histories.create({
            customer_id: req.body.customer_id,
            business_id: business.ID,
            subject: subject ? subject : 'avamgt.com',
            message: text,
            is_success: is_success,
            send_at: dateTime,
            sending_type: 'Email',
            message_type: 'customerSendLink',
          });
        }
      });
      let bookingData = await bookingService.getBookingDataByUser(req.body.user_id);

      res.status(200).send({
        success: true,
        result: bookingData,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async addBookingViaPublic(req, res) {
    let random_key = bookingService.generateKey(8);
    let dateTime = new Date();
    var newCustomer = await customers.findOne({
      where: {
        user_id: req.body.user_id,
        email: req.body.email,
      },
    });
    if (!newCustomer) {
      newCustomer = await customers.create({
        user_id: req.body.user_id,
        name: req.body.name,
        email: req.body.email,
        phone: req.body.phone,
        created_at: dateTime,
        updated_at: dateTime,
      });
    }
    await bookings.create({
      user_id: req.body.user_id,
      customer_id: req.body.customer_id ? req.body.customer_id : newCustomer.id,
      service_id: JSON.stringify(req.body.service_id),
      title: req.body.title,
      note: req.body.note,
      resource: req.body.resource,
      startDate: req.body.startDate,
      appointment_time: dateTime,
      endDate: req.body.endDate,
      appointment_key: random_key,
    });
    res.status(200).send({
      success: true,
    });
  },
  async serveBooking(req, res) {
    let admin_id = await settingsService.getAdminId(req.user.id);
    const AlertSetting = await settingsService.getAlertSetting(admin_id);
    let business = await settingsService.getBusiness(admin_id);
    let currentUser = await settingsService.getUser(req.user.id);
    let dateTime = new Date();
    let bookingSetting = await bookingSettings.findOne({
      where: {
        user_id: admin_id,
      },
    });
    try {
      await bookings.update(
        { serve_time: dateTime, done_time: null },
        {
          where: {
            id: req.params.id,
          },
        },
      );
      let booking = await bookings.findOne({
        where: {
          id: req.params.id,
        },
      });
      await waitlists.create({
        service_id: booking.service_id,
        serve_time: dateTime,
        user_id: booking.user_id,
        customer_id: booking.customer_id,
        is_show: 1,
        booking_id: booking.id,
        resource_id: booking.resource,
      });

      let result = AlertSetting.find((e) => e.key == 'BookingServed');
      let sendingData = JSON.parse(result.data_field);
      let customer = await customers.findOne({
        where: {
          id: booking.customer_id,
        },
      });
      new Promise(async () => {
        //send SMS
        let message = sendingData['sms_template'];
        message = message.replace(/{name}/g, customer.name);
        message = message.replace(/{user}/g, currentUser.username);
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
          let text = sendingData['email_template'];
          subject = subject.replace(/{name}/g, customer.name);
          subject = subject.replace(/{user}/g, currentUser.username);
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
          text = text.replace(/{user}/g, currentUser.username);
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
      });

      res.status(200).send({
        success: true,
        result: booking,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async updateBooking(req, res) {
    console.log(req.user,"++++++++++++++++++++++");
    try {
      await customersService.UpdateCustomer(req.body, req.body.customer_id);

      // console.log('------------------',JSON.stringify(req.body.service_id))
      await bookings.update(
        {
          customer_id: req.body.customer_id,
          title: req.body.title,
          resource: req.body.resource,
          service_id: JSON.stringify(req.body.service_id),
          note: req.body.note,
          startDate: req.body.startDate,
          endDate: req.body.endDate,
        },
        {
          where: {
            id: req.body.id,
          },
        },
      );
      await waitlists.update(
        {
          resource_id: req.body.resource,
          service_id: JSON.stringify(req.body.service_id),
        },
        {
          where: {
            booking_id: req.body.id,
          },
        },
      );

      let bookingData = await bookingService.getBookingDataByUser(req.user.id);

      res.status(200).send({
        success: true,
        result: bookingData,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async reminder() {
    let dateTime = new Date();
    let allUser = await users.findAll({
      where: {
        role: {
          [Op.is]: null,
        },
      },
    });
    allUser.forEach(async (user) => {
      let dateTime = new Date();

      const AlertSetting = await settingsService.getAlertSetting(user.id);
      let result = AlertSetting.find((e) => e.key == 'BookingReminder');
      let sendingData = JSON.parse(result.data_field);
      let business = await settingsService.getBusiness(user.id);
      let remaing = await bookingService.getRemaingDuration(sendingData['remaining_time']);
      let bookingSetting = await bookingSettings.findOne({
        where: {
          user_id: user.id,
        },
      });
      let scheuledAppointments = await bookings.findAll({
        where: {
          [Op.and]: [
            {
              startDate: {
                [Op.gte]: moment(dateTime),
              },
            },
            {
              startDate: {
                [Op.lte]: moment(dateTime).add(remaing[0], remaing[1]),
              },
            },
          ],
          user_id: user.id,
        },
      });
      scheuledAppointments.forEach(async (appointment) => {
        if (appointment['is_remind'] == 0) {
          let customer = await customers.findOne({
            where: {
              id: appointment.customer_id,
            },
          });
          if (customer) {
            //send SMS
            let message = sendingData['sms_template'];
            message = message.replace(/{name}/g, customer.name);
            message = message.replace(/{user}/g, user.username);
            message = message.replace(/{business}/g, business['business_name']);
            message = message.replace(
              /{link}/g,
              `http://avamgt.com/public/customer/booking/${bookingSetting.PublicBookingUrl}`,
            );
            message = message.replace(/{time}/g, moment(appointment.startDate).format('h:mm a'));
            message = message.replace(/{date}/g, moment(appointment.date).format('MMM Do'));
            message = message.replace(/{hour}/g, moment(appointment.startDate).format('h:mm a'));
            message = message.replace(/{cancelUrl}/, `http://avamgt.com/appointment/${booking.appointment_key}`);
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
              let text = sendingData['email_template'];
              subject = subject.replace(/{name}/g, customer.name);
              subject = subject.replace(/{user}/g, user.username);
              subject = subject.replace(/{business}/g, business['business_name']);
              subject = subject.replace(
                /{link}/g,
                `http://avamgt.com/public/customer/booking/${bookingSetting.PublicBookingUrl}`,
              );
              subject = subject.replace(/{time}/g, moment(appointment.startDate).format('h:mm a'));
              subject = subject.replace(/{date}/g, moment(appointment.date).format('MMM Do'));
              subject = subject.replace(/{hour}/g, moment(appointment.startDate).format('h:mm a'));
              subject = subject.replace(/{cancelUrl}/, `http://avamgt.com/appointment/${booking.appointment_key}`);
              text = text.replace(/{name}/g, customer.name);
              text = text.replace(/{user}/g, user.username);
              text = text.replace(/{business}/g, business['business_name']);
              text = text.replace(
                /{link}/g,
                `http://avamgt.com/public/customer/booking/${bookingSetting.PublicBookingUrl}`,
              );
              text = text.replace(/{time}/g, moment(appointment.startDate).format('h:mm a'));
              text = text.replace(/{date}/g, moment(appointment.date).format('MMM Do'));
              text = text.replace(/{hour}/g, moment(appointment.startDate).format('h:mm a'));
              text = text.replace(/{cancelUrl}/, `http://avamgt.com/appointment/${booking.appointment_key}`);
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
          await bookings.update(
            { is_remind: 1 },
            {
              where: {
                id: appointment.id,
              },
            },
          );
        }
      });
    });
  },

  async deleteBooking(req, res) {
    try {
      await bookings.destroy({
        where: {
          id: req.params.id,
        },
      });
      await waitlists.destroy({
        where: {
          booking_id: req.params.id,
        },
      });

      res.status(200).send({
        success: true,
        result: req.params.id,
      });
    } catch (e) {
      console.log(e);
    }
  },
};
