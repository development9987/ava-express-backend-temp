const { Op } = require('sequelize');

const moment = require('moment');
const db = require('../db/models');

const { waitlists, customers, message_histories, resources, bookings, users } = db;
const waitlistSettings = db.waitlist_setting;
const bookingSettings = db.booking_setting;

const customersService = require('../services/customers/customers.service');
const twilioService = require('../services/twilio/twilio.service');
const emailService = require('../services/email/email.service');
const settingsService = require('../services/settings/settings.service');
const { getResultQuery } = require('../core/util');

module.exports = {
  async getWaitlists(req, res) {
    const customerData = await customersService.getCustomerByUser(req.params.user_id);
    const waitlistData = await customersService.getCustomerByWaitlist(req.params.user_id);
    const servedData = await customersService.getCustomerByServe(req.params.user_id);
    const priorityData = await customersService.getCustomerByPriority(req.params.user_id);
    res.status(200).send({
      success: true,
      result: {
        customer_data: customerData,
        waitlist_data: waitlistData,
        served_data: servedData,
        priority_data:priorityData,
      },
    });
  },

  async addWaitlist(req, res) {
    console.log(req.body," +++++++++++++++++++++++++");

    const admin_id = await settingsService.getAdminId(req.body.user_id);
    const AlertSetting = await settingsService.getAlertSetting(admin_id);
    const business = await settingsService.getBusiness(admin_id);
    const currentUser = await settingsService.getUser(req.body.customer_id);


    const waitlistSetting = await waitlistSettings.findOne({
      where: {
        user_id: admin_id,
      },
    });
    const dateTime = moment(moment().toISOString());
    // console.log('-------------------------------------------', dateTime);
    const user = await users.findOne({
      where: {
        id: req.body.user_id,
      },
    });
    let resource_id;
    console.log('test1')
    if (user.role == 'resource') {
      console.log('test2')
      const resource = await resources.findOne({
        where: {
          name: user.username,
          email: user.email,
        },
      });
      if (resource) {
        console.log('test3')
        resource_id = resource.ID;
      }
    } else {
      console.log('test4')
      resource_id = req.body.resource_id;
    }
    try {
      let customer = null;
      if (req.body.is_add)
        customer = await customers.findOne({
          where: { email: req.body.email, user_id: admin_id },
        });
      else
        customer = await customers.findOne({
          where: { id: req.body.customer_id, user_id: admin_id },
        });
        console.log('test5');
      if (customer) {
        console.log('test6');
        await customersService.UpdateCustomer(req.body, customer.id);
      } else {
        console.log('test7');
        customer = await customersService.createNewCustomer(req.body);
      }

      if (req.body.is_add) {
        console.log('test8');
        const result = AlertSetting.find((e) => e.key == 'Confirmation');
        const sendingData = JSON.parse(result.data_field);
        if (req.body.modal_type == 'waitlist') {
          console.log('test9');
          const order_num = await waitlists.count({ where: { user_id: admin_id, serve_time: null } });
          // add waitlist
          const waitlist = await waitlists.create({
            user_id: admin_id,
            service_id: JSON.stringify(req.body.service_id),
            customer_id: customer.id,
            resource_id,
            wait_time: dateTime,
            order_num: order_num,
          });

          const user = await users.findOne({ where: { id: admin_id } });
          // console.log(currentUser,"+++++++++++++++++++++++++++++++++")
          new Promise(async () => {
            // send SMS
            let message = sendingData.sms_template;
            message = message.replace(/{name}/g, req.body.name);
            message = message.replace(/{user}/g, currentUser.username);
            message = message.replace(/{business}/g, business.business_name);
            message = message.replace(/{order}/g, 1);
            message = message.replace(
              /{link}/g,
              `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
            );
            message = message.replace(
              /{cancelUrl}/,
              `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${waitlist.id}`,
            );
            if (sendingData.SendAsSMS) {
              console.log('test10');
              var is_success = await twilioService.sendSMS(req.body.phone, message);
              await message_histories.create({
                customer_id: customer.id,
                business_id: business.ID,
                message,
                is_success,
                send_at: dateTime,
                sending_type: 'SMS',
                message_type: 'customerSendLink',
              });
            }
            // Send Email
            if (sendingData.SendAsEmail) {
              console.log('test11');
              let subject = sendingData.subject ? sendingData.subject : '';
              let text = sendingData.email_template;
              subject = subject.replace(/{name}/g, req.body.name);
              subject = subject.replace(/{user}/g, currentUser.username);
              subject = subject.replace(/{business}/g, business.business_name);
              subject = subject.replace(/{order}/g, 1);
              subject = subject.replace(
                /{link}/g,
                `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
              );
              subject = subject.replace(
                /{cancelUrl}/,
                `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${waitlist.id}`,
              );
              text = text.replace(/{name}/g, req.body.name);
              text = text.replace(/{user}/g, currentUser.username);
              text = text.replace(/{business}/g, business.business_name);
              text = text.replace(/{order}/g, 1);
              text = text.replace(
                /{link}/g,
                `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
              );
              text = text.replace(
                /{cancelUrl}/,
                `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${waitlist.id}`,
              );
              const emailData = {
                template: 'alerts',
                message: {
                  from: 'info@avamgt.com',
                  to: req.body.email,
                },
                locals: {
                  subject: subject || 'avamgt.com',
                  message: text,
                },
              };
              var is_success = await emailService.sendEmail(emailData);

              await message_histories.create({
                customer_id: customer.id,
                business_id: business.ID,
                subject: subject || 'avamgt.com',
                message: text,
                is_success,
                send_at: dateTime,
                sending_type: 'Email',
                message_type: 'customerSendLink',
              });
            }
          });
        } else {
          console.log('test12');
          const result = AlertSetting.find((e) => e.key == 'Served');
          const sendingData = JSON.parse(result.data_field);
          // served
          const waitlist = await waitlists.create({
            service_id: JSON.stringify(req.body.service_id),
            user_id: admin_id,
            customer_id: customer.id,
            resource_id,
            serve_time: dateTime,
          });
          new Promise(async () => {
            // send SMS
            console.log('test13');
            let message = sendingData.sms_template;
            message = message.replace(/{name}/g, req.body.name);
            message = message.replace(/{user}/g, currentUser.username);
            message = message.replace(/{business}/g, business.business_name);
            message = message.replace(/{order}/g, 1);
            message = message.replace(
              /{link}/g,
              `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
            );
            message = message.replace(
              /{cancelUrl}/,
              `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${waitlist.id}`,
            );
            if (sendingData.SendAsSMS) {
              console.log('test14');
              var is_success = await twilioService.sendSMS(req.body.phone, message);
              await message_histories.create({
                customer_id: customer.id,
                business_id: business.ID,
                message,
                is_success,
                send_at: dateTime,
                sending_type: 'SMS',
                message_type: 'customerSendLink',
              });
            }
            // Send Email
            if (sendingData.SendAsEmail) {
              console.log('test15');
              let subject = sendingData.subject ? sendingData.subject : '';
              let text = sendingData.email_template;
              subject = subject.replace(/{name}/g, req.body.name);
              subject = subject.replace(/{user}/g, currentUser.username);
              subject = subject.replace(/{business}/g, business.business_name);
              subject = subject.replace(/{order}/g, 1);
              subject = subject.replace(
                /{link}/g,
                `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
              );
              subject = subject.replace(
                /{cancelUrl}/,
                `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${waitlist.id}`,
              );
              text = text.replace(/{name}/g, req.body.name);
              text = text.replace(/{user}/g, currentUser.username);
              text = text.replace(/{business}/g, business.business_name);
              text = text.replace(/{order}/g, 1);
              text = text.replace(
                /{link}/g,
                `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
              );
              text = text.replace(
                /{cancelUrl}/,
                `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${waitlist.id}`,
              );

              const emailData = {
                template: 'alerts',
                message: {
                  from: 'info@avamgt.com',
                  to: req.body.email,
                },
                locals: {
                  subject: subject || 'avamgt.com',
                  message: text,
                },
              };
              var is_success = await emailService.sendEmail(emailData);

              await message_histories.create({
                customer_id: customer.id,
                business_id: business.ID,
                subject: subject || 'avamgt.com',
                message: text,
                is_success,
                send_at: dateTime,
                sending_type: 'Email',
                message_type: 'customerSendLink',
              });
            }
          });
        }
      } else {
        // console.log(req.body,"___________")
        // if (req.body.booking_id != '0') {
        if (req.body.customer_id != '0') {

          console.log('test16');
          await bookings.update(
            { resource: resource_id, service_id: JSON.stringify(req.body.service_id) },
            {
              where: {
                // id: req.body.booking_id,
                id: req.body.customer_id,
              },
            },
          );
        }
        await waitlists.update(
          { resource_id, service_id: JSON.stringify(req.body.service_id) },
          {
            where: {
              id: req.body.id,
              user_id: admin_id,
              customer_id: req.body.customer_id,
            },
          },
        );
      }
      const customerData = await customersService.getCustomerByUser(req.body.user_id);
      const waitlistData = await customersService.getCustomerByWaitlist(req.body.user_id);
      const servedData = await customersService.getCustomerByServe(req.body.user_id);
      res.status(200).send({
        success: true,
        result: {
          customer_data: customerData,
          waitlist_data: waitlistData,
          served_data: servedData,
        },
      });
    } catch (e) {
      console.log('test17');
      console.log(e);
    }
  },

  async updateWaitlist(req, res) {
    const admin_id = await settingsService.getAdminId(req.body.user_id);
    const AlertSetting = await settingsService.getAlertSetting(admin_id);
    const business = await settingsService.getBusiness(admin_id);
    const dateTime = moment(moment().toISOString());
    const currentUser = await settingsService.getUser(req.body.user_id);
    const waitlistSetting = await waitlistSettings.findOne({
      where: {
        user_id: admin_id,
      },
    });
    try {
      if (req.body.serve_time) {
        await waitlists.update({ is_show: 0, done_time: dateTime }, { where: { id: req.body.id } });
        if (req.body.booking_id != '0') {
          const booking = await bookings.findOne({
            where: {
              id: req.body.booking_id,
            },
          });
          const bookingSetting = await bookingSettings.findOne({
            where: {
              user_id: admin_id,
            },
          });
          const result = AlertSetting.find((e) => e.key == 'BookingCompleted');
          const sendingData = JSON.parse(result.data_field);
          await bookings.update(
            { done_time: dateTime },
            {
              where: {
                id: req.body.booking_id,
              },
            },
          );

          new Promise(async () => {
            // send SMS
            let message = sendingData.sms_template;
            message = message.replace(/{name}/g, req.body.name);
            message = message.replace(/{user}/g, currentUser.username);
            message = message.replace(/{business}/g, business.business_name);
            message = message.replace(
              /{link}/g,
              `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
            );
            message = message.replace(/{time}/g, moment(booking.startDate).format('h:mm a'));
            message = message.replace(/{date}/g, moment(booking.date).format('MMM Do'));
            message = message.replace(/{hour}/g, moment(booking.startDate).format('h:mm a'));
            message = message.replace(/{cancelUrl}/, `${req.headers.referer}appointment/${booking.appointment_key}`);
            if (sendingData.SendAsSMS) {
              var is_success = await twilioService.sendSMS(req.body.phone, message);
              await message_histories.create({
                customer_id: req.body.customer_id,
                business_id: business.ID,
                message,
                is_success,
                send_at: dateTime,
                sending_type: 'SMS',
                message_type: 'customerSendLink',
              });
            }
            // Send Email
            if (sendingData.SendAsEmail) {
              let subject = sendingData.subject ? sendingData.subject : '';
              let text = sendingData.email_template;
              subject = subject.replace(/{name}/g, req.body.name);
              subject = subject.replace(/{user}/g, currentUser.username);
              subject = subject.replace(/{business}/g, business.business_name);
              subject = subject.replace(
                /{link}/g,
                `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
              );
              subject = subject.replace(/{time}/g, moment(booking.startDate).format('h:mm a'));
              subject = subject.replace(/{date}/g, moment(booking.date).format('MMM Do'));
              subject = subject.replace(/{hour}/g, moment(booking.startDate).format('h:mm a'));
              subject = subject.replace(/{cancelUrl}/, `${req.headers.referer}appointment/${booking.appointment_key}`);
              text = text.replace(/{name}/g, req.body.name);
              text = text.replace(/{user}/g, currentUser.username);
              text = text.replace(/{business}/g, business.business_name);
              text = text.replace(
                /{link}/g,
                `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
              );
              text = text.replace(/{time}/g, moment(booking.startDate).format('h:mm a'));
              text = text.replace(/{date}/g, moment(booking.date).format('MMM Do'));
              text = text.replace(/{hour}/g, moment(booking.startDate).format('h:mm a'));
              text = text.replace(/{cancelUrl}/, `${req.headers.referer}appointment/${booking.appointment_key}`);

              const emailData = {
                template: 'alerts',
                message: {
                  from: 'info@avamgt.com',
                  to: req.body.email,
                },
                locals: {
                  subject: subject || 'avamgt.com',
                  message: text,
                },
              };
              var is_success = await emailService.sendEmail(emailData);

              await message_histories.create({
                customer_id: req.body.customer_id,
                business_id: business.ID,
                subject: subject || 'avamgt.com',
                message: text,
                is_success,
                send_at: dateTime,
                sending_type: 'Email',
                message_type: 'customerSendLink',
              });
            }
          });
        } else {
          const result = AlertSetting.find((e) => e.key == 'Completed');
          const sendingData = JSON.parse(result.data_field);

          new Promise(async () => {
            // send SMS
            let message = sendingData.sms_template;
            message = message.replace(/{name}/g, req.body.name);
            message = message.replace(/{user}/g, currentUser.username);
            message = message.replace(/{business}/g, business.business_name);
            message = message.replace(/{order}/g, 1);
            message = message.replace(
              /{link}/g,
              `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
            );
            message = message.replace(
              /{cancelUrl}/,
              `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
            );
            if (sendingData.SendAsSMS) {
              var is_success = await twilioService.sendSMS(req.body.phone, message);
              await message_histories.create({
                customer_id: req.body.customer_id,
                business_id: business.ID,
                message,
                is_success,
                send_at: dateTime,
                sending_type: 'SMS',
                message_type: 'customerSendLink',
              });
            }
            // Send Email
            if (sendingData.SendAsEmail) {
              const subject = sendingData.subject ? sendingData.subject : '';
              let text = sendingData.email_template;
              message = message.replace(/{name}/g, req.body.name);
              message = message.replace(/{business}/g, business.business_name);
              message = message.replace(/{order}/g, 1);
              message = message.replace(
                /{link}/g,
                `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
              );
              message = message.replace(
                /{cancelUrl}/,
                `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
              );
              text = text.replace(/{name}/g, req.body.name);
              text = text.replace(/{user}/g, currentUser.username);
              text = text.replace(/{business}/g, business.business_name);
              text = text.replace(/{order}/g, 1);
              text = text.replace(
                /{link}/g,
                `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
              );
              text = text.replace(
                /{cancelUrl}/,
                `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
              );

              const emailData = {
                template: 'alerts',
                message: {
                  from: 'info@avamgt.com',
                  to: req.body.email,
                },
                locals: {
                  subject: subject || 'avamgt.com',
                  message: text,
                },
              };
              var is_success = await emailService.sendEmail(emailData);

              await message_histories.create({
                customer_id: req.body.customer_id,
                business_id: business.ID,
                subject: subject || 'avamgt.com',
                message: text,
                is_success,
                send_at: dateTime,
                sending_type: 'Email',
                message_type: 'customerSendLink',
              });
            }
          });
        }
      } else {
        if(req.body.priority && req.body.priority != 'null' && typeof req.body.priority != 'undefined'){
          await waitlists.update({ priority: req.body.priority }, { where: { id: req.body.id } });
        }else if(req.body.priority == 'null'){
          await waitlists.update({ priority: '', serve_time: dateTime }, { where: { id: req.body.id } });
        }else{
          await waitlists.update({ serve_time: dateTime }, { where: { id: req.body.id } });
        }
        await waitlists.update(
          { order_num: db.sequelize.literal('order_num-1') },
          { where: { order_num: { [Op.gt]: req.body.order_num } } },
        );
        const result = AlertSetting.find((e) => e.key == 'Served');
        const sendingData = JSON.parse(result.data_field);
        new Promise(async () => {
          // send SMS
          let message = sendingData.sms_template;
          message = message.replace(/{name}/g, req.body.name);
          message = message.replace(/{user}/g, currentUser.username);
          message = message.replace(/{business}/g, business.business_name);
          message = message.replace(/{order}/g, 1);
          message = message.replace(
            /{link}/g,
            `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
          );
          message = message.replace(
            /{cancelUrl}/,
            `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
          );
          if (sendingData.SendAsSMS) {
            var is_success = await twilioService.sendSMS(req.body.phone, message);
            await message_histories.create({
              customer_id: req.body.customer_id,
              business_id: business.ID,
              message,
              is_success,
              send_at: dateTime,
              sending_type: 'SMS',
              message_type: 'customerSendLink',
            });
          }
          // Send Email
          if (sendingData.SendAsEmail) {
            let subject = sendingData.subject ? sendingData.subject : '';
            let text = sendingData.email_template;
            subject = subject.replace(/{name}/g, req.body.name);
            subject = subject.replace(/{user}/g, currentUser.username);
            subject = subject.replace(/{business}/g, business.business_name);
            subject = subject.replace(/{order}/g, 1);
            subject = subject.replace(
              /{link}/g,
              `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
            );
            subject = subject.replace(
              /{cancelUrl}/,
              `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
            );
            text = text.replace(/{name}/g, req.body.name);
            text = text.replace(/{user}/g, currentUser.username);
            text = text.replace(/{business}/g, business.business_name);
            text = text.replace(/{order}/g, 1);
            text = text.replace(
              /{link}/g,
              `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
            );
            text = text.replace(
              /{cancelUrl}/,
              `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
            );
            const emailData = {
              template: 'alerts',
              message: {
                from: 'info@avamgt.com',
                to: req.body.email,
              },
              locals: {
                subject: subject || 'avamgt.com',
                message: text,
              },
            };
            var is_success = await emailService.sendEmail(emailData);

            await message_histories.create({
              customer_id: req.body.customer_id,
              business_id: business.ID,
              subject: subject || 'avamgt.com',
              message: text,
              is_success,
              send_at: dateTime,
              sending_type: 'Email',
              message_type: 'customerSendLink',
            });
          }
        });
      }

      const waitlistData = await customersService.getCustomerByWaitlist(req.body.user_id);
      const servedData = await customersService.getCustomerByServe(req.body.user_id);

      res.status(200).send({
        success: true,
        result: {
          waitlist_data: waitlistData,
          served_data: servedData,
        },
      });
    } catch (e) {
      console.log(e);
    }
  },

  async updateWaitlistOrderNum(req, res) {
    const admin_id = await settingsService.getAdminId(req.user.id);
    const AlertSetting = await settingsService.getAlertSetting(admin_id);
    const business = await settingsService.getBusiness(admin_id);
    const currentUser = await settingsService.getUser(req.user.id);
    const waitlistSetting = await waitlistSettings.findOne({
      where: {
        user_id: admin_id,
      },
    });
    const dateTime = moment(moment().toISOString());
    try {
      if (req.body.order_num > req.body.old_order_num) {
        // await waitlists.update({ order_num: db.sequelize.literal("order_num-1") }, { where: { order_num: { [Op.lt]: req.body.old_order_num },order_num: { [Op.gte]: req.body.order_num } } });
        await waitlists.update(
          { order_num: db.sequelize.literal('order_num-1') },
          {
            where: {
              [Op.and]: [
                {
                  order_num: { [Op.gt]: req.body.old_order_num },
                },
                {
                  order_num: { [Op.lte]: req.body.order_num },
                },
              ],
              user_id: admin_id,
            },
          },
        );
        await waitlists.update({ order_num: req.body.order_num }, { where: { id: req.body.id } });
      } else if (req.body.order_num < req.body.old_order_num) {
        await waitlists.update(
          { order_num: db.sequelize.literal('order_num+1') },
          {
            where: {
              [Op.and]: [
                {
                  order_num: { [Op.lt]: req.body.old_order_num },
                },
                {
                  order_num: { [Op.gte]: req.body.order_num },
                },
              ],
              user_id: admin_id,
            },
          },
        );
        await waitlists.update({ order_num: req.body.order_num }, { where: { id: req.body.id } });
      }

      const customer = await getResultQuery(
        `SELECT t1.* FROM waitlists AS t0 LEFT JOIN customers AS t1 ON t0.customer_id = t1.id WHERE t0.id = ${req.body.id}`,
      );
      const result = AlertSetting.find((e) => e.key == 'NextInLine');
      const sendingData = JSON.parse(result.data_field);
      // console.log(sendingData.order_line, req.body.order_num);
      if (sendingData.order_line == req.body.order_num) {
        new Promise(async () => {
          let message = sendingData.sms_template;
          message = message.replace(/{name}/g, customer[0].name);
          message = message.replace(/{user}/g, currentUser.username);
          message = message.replace(/{business}/g, business.business_name);
          message = message.replace(/{order}/g, 1);
          message = message.replace(
            /{link}/g,
            `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
          );
          message = message.replace(
            /{cancelUrl}/,
            `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
          );
          if (sendingData.SendAsSMS) {
            var is_success = await twilioService.sendSMS(customer[0].phone, message);
            await message_histories.create({
              customer_id: customer[0].id,
              business_id: business.ID,
              message,
              is_success,
              send_at: dateTime,
              sending_type: 'SMS',
              message_type: 'customerSendLink',
            });
          }
          // Send Email
          if (sendingData.SendAsEmail) {
            let subject = sendingData.subject ? sendingData.subject : '';
            let text = sendingData.email_template;
            subject = subject.replace(/{name}/g, customer[0].name);
            subject = subject.replace(/{user}/g, currentUser.username);
            subject = subject.replace(/{business}/g, business.business_name);
            subject = subject.replace(/{order}/g, 1);
            subject = subject.replace(
              /{link}/g,
              `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
            );
            text = text.replace(/{name}/g, customer[0].name);
            text = text.replace(/{user}/g, currentUser.username);
            text = text.replace(/{business}/g, business.business_name);
            text = text.replace(/{order}/g, 1);
            text = text.replace(
              /{link}/g,
              `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
            );
            text = text.replace(
              /{cancelUrl}/,
              `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
            );
            const emailData = {
              template: 'alerts',
              message: {
                from: 'info@avamgt.com',
                to: customer[0].email,
              },
              locals: {
                subject: subject || 'avamgt.com',
                message: text,
              },
            };
            var is_success = await emailService.sendEmail(emailData);
            await message_histories.create({
              customer_id: customer[0].id,
              business_id: business.ID,
              subject: subject || 'avamgt.com',
              message: text,
              is_success,
              send_at: dateTime,
              sending_type: 'Email',
              message_type: 'customerSendLink',
            });
          }
        });
      }

      res.status(200).send({
        success: true,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async deleteWaitlist(req, res) {
    try {
      const user = await getResultQuery(
        `SELECT t1.* FROM waitlists AS t0 LEFT JOIN users AS t1 ON t1.id = t0.user_id WHERE t0.id = ${req.params.id}`,
      );
      const admin_id = await settingsService.getAdminId(user[0].id);
      const currentUser = await settingsService.getUser(user[0].id);
      const dateTime = moment(moment().toISOString());
      const deletedUser = await waitlists.findOne({
        where: {
          id: req.params.id,
        },
      });
      if (!deletedUser.booking_id) {
        await waitlists.update(
          { order_num: db.sequelize.literal('order_num-1') },
          {
            where: {
              order_num: { [Op.gt]: deletedUser.order_num },
              user_id: deletedUser.user_id,
            },
          },
        );

        const customer = await getResultQuery(
          `SELECT t1.* FROM waitlists AS t0 LEFT JOIN customers AS t1 ON t0.customer_id = t1.id WHERE t0.id = ${req.params.id}`,
        );
        const AlertSetting = await settingsService.getAlertSetting(admin_id);
        const business = await settingsService.getBusiness(admin_id);
        const waitlistSetting = await waitlistSettings.findOne({
          where: {
            user_id: admin_id,
          },
        });
        const result = AlertSetting.find((e) => e.key == 'Cancelled');
        const sendingData = JSON.parse(result.data_field);
        new Promise(async () => {
          // send SMS
          let message = sendingData.sms_template;
          message = message.replace(/{name}/g, customer[0].name);
          message = message.replace(/{user}/g, currentUser.username);
          message = message.replace(/{business}/g, business.business_name);
          message = message.replace(/{order}/g, 1);
          message = message.replace(
            /{cancelUrl}/,
            `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.params.id}`,
          );
          message = message.replace(
            /{link}/g,
            `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
          );
          if (sendingData.SendAsSMS) {
            var is_success = await twilioService.sendSMS(customer[0].phone, message);
            await message_histories.create({
              customer_id: customer[0].id,
              business_id: business.ID,
              message,
              is_success,
              send_at: dateTime,
              sending_type: 'SMS',
              message_type: 'customerSendLink',
            });
          }
          // Send Email
          if (sendingData.SendAsEmail) {
            let subject = sendingData.subject ? sendingData.subject : '';
            let text = sendingData.email_template;
            subject = subject.replace(/{name}/g, customer[0].name);
            subject = subject.replace(/{user}/g, currentUser.username);
            subject = subject.replace(/{business}/g, business.business_name);
            subject = subject.replace(/{order}/g, 1);
            subject = subject.replace(
              /{cancelUrl}/,
              `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.params.id}`,
            );
            subject = subject.replace(
              /{link}/g,
              `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
            );
            text = text.replace(/{name}/g, customer[0].name);
            text = text.replace(/{user}/g, currentUser.username);
            text = text.replace(/{business}/g, business.business_name);
            text = text.replace(/{order}/g, 1);
            text = text.replace(
              /{cancelUrl}/,
              `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.params.id}`,
            );
            text = text.replace(
              /{link}/g,
              `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
            );
            const emailData = {
              template: 'alerts',
              message: {
                from: 'info@avamgt.com',
                to: customer[0].email,
              },
              locals: {
                subject: subject || 'avamgt.com',
                message: text,
              },
            };
            var is_success = await emailService.sendEmail(emailData);

            await message_histories.create({
              customer_id: customer[0].id,
              business_id: business.ID,
              subject: subject || 'avamgt.com',
              message: text,
              is_success,
              send_at: dateTime,
              sending_type: 'Email',
              message_type: 'customerSendLink',
            });
          }
        });
      } else {
        await bookings.destroy({
          where: {
            id: deletedUser.booking_id,
          },
        });
      }
      await waitlists.destroy({
        where: {
          id: req.params.id,
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

  async servedToWaitlist(req, res) {
    const AlertSetting = await settingsService.getAlertSetting(req.body.user_id);
    const business = await settingsService.getBusiness(req.body.user_id);
    // console.log(req.body,"___________________")

    const currentUser = await settingsService.getUser(req.body.id);
    const waitlistSetting = await waitlistSettings.findOne({
      where: {
        user_id: req.body.user_id,
      },
    });
    const result = AlertSetting.find((e) => e.key == 'Confirmation');
    const sendingData = JSON.parse(result.data_field);
    try {
      const dateTime = moment(moment().toISOString());
      await waitlists.update(
        { order_num: db.sequelize.literal('order_num+1') },
        { where: { user_id: req.body.user_id, serve_time: null } },
      );
      await waitlists.update({ wait_time: dateTime, serve_time: null, order_num: 1 }, { where: { id: req.body.id } });

      const user = await users.findOne({ where: { id: req.body.user_id } });

      const waitlistData = await customersService.getCustomerByWaitlist(req.user.id);
      const servedData = await customersService.getCustomerByServe(req.user.id);

      new Promise(async () => {
        // send SMS
        let message = sendingData.sms_template;
        message = message.replace(/{name}/g, req.body.name);
        message = message.replace(/{user}/g, currentUser.username);
        message = message.replace(/{business}/g, business.business_name);
        message = message.replace(/{order}/g, 1);
        message = message.replace(
          /{cancelUrl}/,
          `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
        );
        message = message.replace(
          /{link}/g,
          `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
        );
        if (sendingData.SendAsSMS) {
          var is_success = await twilioService.sendSMS(req.body.phone, message);
          await message_histories.create({
            customer_id: req.body.customer_id,
            business_id: business.ID,
            message,
            is_success,
            send_at: dateTime,
            sending_type: 'SMS',
            message_type: 'customerSendLink',
          });
        }
        // Send Email
        if (sendingData.SendAsEmail) {
          let subject = sendingData.subject ? sendingData.subject : '';
          let text = sendingData.email_template;
          subject = subject.replace(/{name}/g, req.body.name);
          subject = subject.replace(/{user}/g, currentUser.username);
          subject = subject.replace(/{business}/g, business.business_name);
          subject = subject.replace(/{order}/g, 1);
          subject = subject.replace(
            /{cancelUrl}/,
            `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
          );
          subject = subject.replace(
            /{link}/g,
            `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
          );
          text = text.replace(/{name}/g, req.body.name);
          text = text.replace(/{user}/g, currentUser.username);
          text = text.replace(/{business}/g, business.business_name);
          text = text.replace(/{order}/g, 1);
          text = text.replace(
            /{cancelUrl}/,
            `${req.headers.referer}public/customer/waitlist/cancel/${waitlistSetting.PublicWaitlistUrl}/${req.body.id}`,
          );
          text = text.replace(
            /{link}/g,
            `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
          );
          const emailData = {
            template: 'alerts',
            message: {
              from: 'info@avamgt.com',
              to: req.body.email,
            },
            locals: {
              subject: subject || 'avamgt.com',
              message: text,
            },
          };
          var is_success = await emailService.sendEmail(emailData);

          await message_histories.create({
            customer_id: req.body.customer_id,
            business_id: business.ID,
            subject: subject || 'avamgt.com',
            message: text,
            is_success,
            send_at: dateTime,
            sending_type: 'Email',
            message_type: 'customerSendLink',
          });
        }
      });
      res.status(200).send({
        success: true,
        result: {
          waitlist_data: waitlistData,
          served_data: servedData,
        },
      });
    } catch (e) {
      console.log(e);
    }
  },

  async addWaitlistViaPublic(req, res) {
    const dateTime = moment(moment().toISOString());
    let customer = await customers.findOne({
      where: {
        user_id: req.body.user_id,
        email: req.body.email,
      },
    });
    if (!customer) {
      customer = await customers.create({
        user_id: req.body.user_id,
        name: req.body.name,
        email: req.body.email,
        phone: req.body.phone,
        created_at: dateTime,
        updated_at: dateTime,
      });
    }
    const order_num = await waitlists.count({ where: { user_id: req.body.user_id, serve_time: null } });
    await waitlists.create({
      service_id: JSON.stringify(req.body.service_id),
      user_id: req.body.user_id,
      customer_id: customer.id,
      wait_time: dateTime,
      order_num: order_num + 1,
      is_show: 1,
    });
    res.status(200).send({
      success: true,
    });
  },
};
