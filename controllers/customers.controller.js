const moment = require('moment');
const { Op, where } = require('sequelize');
const db = require('../db/models');

const { customers } = db;
const { resources } = db;
const { users } = db;
const { customer_meta } = db;
const { user_meta } = db;

const clientFields = db.client_fields;
const { message_histories } = db;
const { waitlists } = db;
const waitlistSettings = db.waitlist_setting;
const { message_templates } = db;
const bookingSettings = db.booking_setting;
const { bookings } = db;

const settingsService = require('../services/settings/settings.service');
const twilioService = require('../services/twilio/twilio.service');
const emailService = require('../services/email/email.service');

customers.hasMany(customer_meta);
customer_meta.belongsTo(customers);
customer_meta.hasMany(clientFields, {
  foreignKey: 'name',
  sourceKey: 'meta_key',
});
clientFields.belongsTo(customer_meta, {
  foreignKey: 'name',
  targetKey: 'meta_key',
});

users.hasMany(user_meta);
user_meta.belongsTo(users);
user_meta.hasMany(clientFields, {
  foreignKey: 'name',
  sourceKey: 'meta_key',
});
clientFields.belongsTo(user_meta, {
  foreignKey: 'name',
  targetKey: 'meta_key',
});

module.exports = {
  async getCustomerUsers(req, res) {
    await users.findAll({
      include: [
        {
          model: user_meta,
          include: [clientFields],
        },
        // {
        // where:{
        //       id:customers.user_id
        // }
        // }
      ]
    })

      .then((customs) => {
        let resObj = customs.map((custom) => {
          // console.log(custom,"++++++++++++++++++++++++");
          let is_available = true;

          if (is_available) {
            return {
              id: custom.id,
              user_id: custom.user_id,
              firstname: custom.firstname,
              lastname: custom.lastname,
              name: custom.username,
              user_group_id: custom.user_group_id,
              // email: custom.email,
              // phone: custom.phone,
              // description: custom.description,
              created_at: custom.created_at,
              updated_at: custom.updated_at,

              meta: custom.user_meta.map((meta_data) => {
                if (meta_data.client_fields[0] != undefined) {
                  return {
                    meta_key: meta_data.meta_key,
                    meta_value: meta_data.meta_value,

                    type: meta_data.client_fields[0].type,
                  };
                }
              }),
            };
          }
        });
        resObj = resObj.filter((item) => item != null);
        res.status(200).send({
          success: true,
          result: resObj,

        });
      });
  },

  async getallCustomers(req, res) {
    // const user = await users.findOne({
    //   where: {
    //     id: req.params.user_id,
    //   },
    // });
    // // console.log(user);
    // let relationCustomers;
    // if (user.role == 'resource') {
    //   const resource = await resources.findOne({
    //     where: {
    //       name: user.username,
    //       email: user.email,
    //     },
    //   });
    //   relationCustomers = await waitlists.findAll({
    //     where: {
    //       resource_id: resource.ID,
    //     },
    //   });
    // }
    // try {
    await customers
      .findAll({
        include: [
          {
            model: customer_meta,
            include: [clientFields],
          },
        ],
        // where: {
        //   user_id: admin_id,
        // },
      })
      .then((customs) => {
        // console.log(customs.length,"++++++++++++++++++++++++");

        let resObj = customs.map((custom) => {
          let is_available = true;
          // if (user.role == 'resource' && relationCustomers.length != 0) {
          //   is_available = false;
          //   for (let index = 0; index < relationCustomers.length; index++) {
          //     if (relationCustomers[index].customer_id == custom.id) {
          //       is_available = true;
          //       break;
          //     }
          //   }
          // }
          if (is_available) {
            return {
              id: custom.id,
              user_id: custom.user_id,
              name: custom.name,
              customer_group_id: custom.customer_group_id,
              email: custom.email,
              phone: custom.phone,
              description: custom.description,
              created_at: custom.created_at,
              updated_at: custom.updated_at,

              meta: custom.customer_meta.map((meta_data) => {
                if (meta_data.client_fields[0] != undefined) {
                  return {
                    meta_key: meta_data.meta_key,
                    meta_value: meta_data.meta_value,

                    type: meta_data.client_fields[0].type,
                  };
                }
              }),
            };
          }
        });
        resObj = resObj.filter((item) => item != null);
        res.status(200).send({
          success: true,
          result: resObj,
        });
        // console.log(resObj.length,"++++++++++++++++++++++++");
      });
    // } catch (e) {
    //   console.log(e);
    // }
  },

  async getCustomers(req, res) {
    const admin_id = await settingsService.getAdminId(req.params.user_id);

    console.log("first ,+++++++++++++++++++++++++++++++++++++++");
    const user = await users.findOne({
      where: {
        id: req.params.user_id,
      },
    });
    // console.log(user);
    let relationCustomers;
    if (user.role == 'resource') {
      const resource = await resources.findOne({
        where: {
          name: user.username,
          email: user.email,
        },
      });
      relationCustomers = await waitlists.findAll({
        where: {
          resource_id: resource.ID,
        },
      });
    }
    try {
      await customers
        .findAll({
          include: [
            {
              model: customer_meta,
              include: [clientFields],
            },
          ],
          where: {
            user_id: admin_id,
          },
        })
        .then((customs) => {
          // console.log(customs.length,"++++++++++++++++++++++++");

          let resObj = customs.map((custom) => {
            let is_available = true;
            if (user.role == 'resource' && relationCustomers.length != 0) {
              is_available = false;
              for (let index = 0; index < relationCustomers.length; index++) {
                if (relationCustomers[index].customer_id == custom.id) {
                  is_available = true;
                  break;
                }
              }
            }
            if (is_available) {
              return {
                id: custom.id,
                user_id: custom.user_id,
                name: custom.name,
                customer_group_id: custom.customer_group_id,
                email: custom.email,
                phone: custom.phone,
                description: custom.description,
                created_at: custom.created_at,
                updated_at: custom.updated_at,

                meta: custom.customer_meta.map((meta_data) => {
                  if (meta_data.client_fields[0] != undefined) {
                    return {
                      meta_key: meta_data.meta_key,
                      meta_value: meta_data.meta_value,

                      type: meta_data.client_fields[0].type,
                    };
                  }
                }),
              };
            }
          });
          resObj = resObj.filter((item) => item != null);
          res.status(200).send({
            success: true,
            result: resObj,
          });
          // console.log(resObj.length,"++++++++++++++++++++++++");
        });
    } catch (e) {
      console.log(e);
    }
  },
  async addCustomer(req, res) {
    let dateTime = new Date();
    dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
    const { name, customer_group_id, email, phone, description, user_id, addition } = req.body;
    const admin_id = await settingsService.getAdminId(req.body.user_id);
    const customer = await customers.findAll({
      where: {
        email,
        user_id: admin_id,
      },
    });
    if (customer.length != 0) {
      res.status(200).send({
        success: false,
        message: 'exists',
      });
    } else {
      try {
        const newCustomer = await customers.create({
          user_id: admin_id,
          name,
          customer_group_id,
          email,
          phone,
          description,
          created_at: dateTime,
          updated_at: dateTime,
        });
        await Promise.all(
          Object.getOwnPropertyNames(addition).map(async (key) => {
            await customer_meta.create({
              meta_key: key,
              meta_value: addition[key],
              customerId: newCustomer.id,
            });
          }),
        );
        let business = await settingsService.addAction('customer_add_time', admin_id);

        customers
          .findAll({
            include: [
              {
                model: customer_meta,
                include: [clientFields],
              },
            ],
            where: {
              id: newCustomer.id,
            },
          })
          .then((customs) => {
            const resObj = customs.map((custom) => {
              return {
                id: custom.id,
                user_id: custom.user_id,
                name: custom.name,
                customer_group_id: custom.customer_group_id,
                email: custom.email,
                phone: custom.phone,
                description: custom.description,
                created_at: custom.created_at,
                updated_at: custom.updated_at,

                meta: custom.customer_meta.map((meta_data) => {
                  if (meta_data.client_fields[0] != undefined) {
                    return {
                      meta_key: meta_data.meta_key,
                      meta_value: meta_data.meta_value,

                      type: meta_data.client_fields[0].type,
                    };
                  }
                }),
              };
            });
            res.status(200).send({
              success: true,
              message: 'Customer Create Successfully',
              result: resObj[0],
              business,
            });
          });
      } catch (e) {
        console.log(e);
      }
    }
  },
  async addWaitlistCustomer(req, res) {
    // console.log(req.params)
    const dateTime = new Date();
    const admin_id = await settingsService.getAdminId(req.params.user_id);
    const AlertSetting = await settingsService.getAlertSetting(admin_id);
    const business = await settingsService.getBusiness(admin_id);
    const currentUser = await settingsService.getUser(req.params.user_id);

    const waitlistSetting = await waitlistSettings.findOne({
      where: {
        user_id: admin_id,
      },
    });
    try {
      const user = await users.findOne({
        where: {
          id: req.body.user_id,
        },
      });
      let resource_id = null;
      if (user.role == 'resource') {
        const resource = await resources.findOne({
          where: {
            name: user.username,
            email: user.email,
          },
        });
        if (resource) {
          resource_id = resource.ID;
        }
      }
      const customer = await customers.findOne({
        where: {
          user_id: admin_id,
          id: req.body.customer_id,
        },
      });
      let waitlist;
      await waitlists.update(
        { order_num: db.sequelize.literal('order_num+1') },
        { where: { user_id: admin_id, serve_time: null } },
      );
      if (resource_id) {
        waitlist = await waitlists.create({
          user_id: admin_id,
          customer_id: req.body.customer_id,
          wait_time: dateTime,
          resource_id,
          order_num: 1,
        });
      } else {
        waitlist = await waitlists.create({
          user_id: admin_id,
          customer_id: req.body.customer_id,
          wait_time: dateTime,
          order_num: 1,
        });
      }

      if (customer) {
        const result = AlertSetting.find((e) => e.key == 'Confirmation');
        const sendingData = JSON.parse(result.data_field);
        new Promise(async () => {
          let message = sendingData.sms_template;
          message = message.replace(/{user}/g, currentUser.username);
          message = message.replace(/{name}/g, customer.name);
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
            var is_success = await twilioService.sendSMS(customer.phone, message);
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
            let subject = sendingData.subject ? sendingData.subject : '';
            let text = sendingData.email_template;
            text = text.replace(/{name}/g, customer.name);
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
            subject = subject.replace(/{name}/g, customer.name);
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

            const emailData = {
              template: 'alerts',
              message: {
                from: 'info@avamgt.com',
                to: customer.email,
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

        res.status(200).send({
          success: true,
        });
      } else {
        res.status(200).send({
          success: false,
        });
      }
    } catch (e) {
      console.log(e);
    }
  },
  async updateCustomer(req, res) {
    let dateTime = new Date();
    dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
    const { name, customer_group_id, email, phone, description, addition } = req.body;
    // console.log(name)
    try {
      await customers.update(
        {
          name,
          customer_group_id,
          email,
          phone,
          description,
          updated_at: dateTime,
        },
        {
          where: {
            id: req.params.id,
          },
        },
      );
      await Promise.all(
        Object.getOwnPropertyNames(addition).map(async (key) => {
          const customerMetaData = await customer_meta.findOne({
            where: {
              customerId: req.params.id,
              meta_key: key,
            },
          });

          if (customerMetaData) {
            await customer_meta.update(
              {
                meta_value: addition[key],
              },
              {
                where: {
                  customerId: req.params.id,
                  meta_key: key,
                },
              },
            );
          } else {
            await customer_meta.create({
              meta_key: key,
              meta_value: addition[key],
              customerId: req.params.id,
            });
          }
        }),
      );
      customers
        .findAll({
          include: [
            {
              model: customer_meta,
              include: [clientFields],
            },
          ],
          where: {
            id: req.params.id,
          },
        })
        .then((customs) => {
          const resObj = customs.map((custom) => {
            return {
              id: custom.id,
              user_id: custom.user_id,
              name: custom.name,
              customer_group_id: custom.customer_group_id,
              email: custom.email,
              phone: custom.phone,
              description: custom.description,
              created_at: custom.created_at,
              updated_at: custom.updated_at,

              meta: custom.customer_meta.map((meta_data) => {
                if (meta_data.client_fields[0] != undefined) {
                  return {
                    meta_key: meta_data.meta_key,
                    meta_value: meta_data.meta_value,

                    type: meta_data.client_fields[0].type,
                  };
                }
              }),
            };
          });
          res.status(200).send({
            success: true,
            message: 'Customer Create Successfully',
            result: resObj[0],
          });
        });
    } catch (e) {
      console.log(e);
    }
  },

  async deleteCustomer(req, res) {
    try {
      await customers.destroy({
        where: {
          id: req.params.id,
        },
      });
      await customer_meta.destroy({
        where: {
          customerId: req.params.id,
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
  async sendLinkToCustomer(req, res) {
    try {
      const adminId = await settingsService.getAdminId(req.user.id);
      const dateTime = moment().format('YYYY-MM-DD HH:mm:ss');
      const business = await settingsService.getBusiness(adminId);
      const currentUser = await settingsService.getUser(req.user.id);
      const waitlistSetting = await waitlistSettings.findOne({
        where: {
          user_id: adminId,
        },
        raw: true,
      });
      const bookingSetting = await bookingSettings.findOne({
        where: {
          user_id: adminId,
        },
        raw: true,
      });
      const template = await message_templates.findOne({
        where: {
          user_id: adminId,
          id: req.body.templateId,
        },
        raw: true,
      });
      const customer = await customers.findOne({
        where: {
          id: req.body.customerId,
        },
        raw: true,
      });
      let is_success = 'success';
      let message = '';
      let subject = '';
      if (req.body.type == 'sms') {
        message = template.sms_template;
        message = message.replace(/{name}/g, customer.name);
        message = message.replace(/{user}/g, currentUser.username);
        message = message.replace(/{business}/g, business.business_name);
        message = message.replace(
          /{w-link}/,
          `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
        );
        message = message.replace(
          /{b-link}/,
          `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
        );
        const sendingResult = await twilioService.sendSMS(customer.phone, message);
        if (!sendingResult) {
          is_success = 'invalid phone';
        }
      } else {
        subject = template.email_subject;
        subject = subject.replace(/{name}/g, customer.name);
        subject = subject.replace(/{user}/g, currentUser.username);
        subject = subject.replace(/{business}/g, business.business_name);
        subject = subject.replace(
          /{w-link}/,
          `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
        );
        subject = subject.replace(
          /{b-link}/,
          `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
        );

        message = template.email_template;
        message = message.replace(/{name}/g, customer.name);
        message = message.replace(/{user}/g, currentUser.username);
        message = message.replace(/{business}/g, business.business_name);
        message = message.replace(
          /{w-link}/,
          `${req.headers.referer}public/customer/waitlist/${waitlistSetting.PublicWaitlistUrl}`,
        );
        message = message.replace(
          /{b-link}/,
          `${req.headers.referer}public/customer/booking/${bookingSetting.PublicBookingUrl}`,
        );
        const emailData = {
          template: 'alerts',
          message: {
            from: 'info@avamgt.com',
            to: customer.email,
          },
          locals: {
            subject,
            message,
          },
        };
        const sendingResult = await emailService.sendEmail(emailData);
        if (!sendingResult) {
          is_success = 'invalid email';
        }
      }
      await message_histories.create({
        customer_id: customer.id,
        business_id: business.ID,
        message,
        subject,
        is_success: is_success == 'success',
        send_at: dateTime,
        sending_type: req.body.type,
        message_type: 'customerSendLink',
      });
      if (is_success == 'success') {
        res.status(200).send({
          success: true,
        });
      } else {
        res.status(200).send({
          success: false,
          message: is_success,
        });
      }
    } catch (e) {
      console.log(e);
    }
  },
  async getMessageHistory(req, res) {
    try {
      const histories = await message_histories.findAll({
        where: {
          customer_id: req.params.id,
        },
        order: [['send_at', 'DESC']],
        raw: true,
      });
      const result = { SMS: [], Email: [] };
      histories.forEach((element) => {
        if (element.sending_type == 'sms') {
          result.SMS.push(element);
        } else if (element.sending_type == 'email') {
          result.Email.push(element);
        }
      });
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async getEventHistory(req, res) {
    try {
      const waitlisted = await waitlists.findAll({
        where: {
          customer_id: req.params.id,
          wait_time: {
            [Op.not]: null,
          },
        },
        order: [['wait_time', 'DESC']],
        raw: true,
      });
      const served = await waitlists.findAll({
        where: {
          customer_id: req.params.id,
          serve_time: {
            [Op.not]: null,
          },
        },
        order: [['serve_time', 'DESC']],
        raw: true,
      });
      const done = await waitlists.findAll({
        where: {
          customer_id: req.params.id,
          done_time: {
            [Op.not]: null,
          },
        },
        order: [['done_time', 'DESC']],
        raw: true,
      });
      const appointmented = await bookings.findAll({
        where: {
          customer_id: req.params.id,
          appointment_time: {
            [Op.not]: null,
          },
        },
        order: [['appointment_time', 'DESC']],
        raw: true,
      });
      const result = [];
      waitlisted.map((e) => {
        result.push({ date: e.wait_time, type: 'waitlisted', order: result.length - 1 });
      });
      served.map((e) => {
        result.push({ date: e.serve_time, type: 'served', order: result.length - 1 });
      });
      done.map((e) => {
        result.push({ date: e.done_time, type: 'done', order: result.length - 1 });
      });
      appointmented.map((e) => {
        result.push({ date: e.appointment_time, type: 'appointmented', order: result.length - 1 });
      });
      result.sort();
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
    }
  },
};
