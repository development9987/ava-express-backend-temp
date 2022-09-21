const sequelize = require('../db/models').Sequelize;

const { Op } = sequelize;

const moment = require('moment');

const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const config = require('../config/auth.config');
const emailService = require('../services/email/email.service');
const SettingsService = require('../services/settings/settings.service');
const stripeService = require('../services/stripe/stripe.service');
const { getResultQuery } = require('../core/util');
const { ResponseFormat } = require('../core');

const {
  users,
  managers,
  resources,
  customers,
  services,
  bookings,
  booking_setting,
  waitlists,
  waitlist_setting,
  alert_setting,
  localization,
  sales,
  sale_datas,
  sales_sequence,
  tasks,
  task_descriptions,
  description_resources,
  messages,
  message_templates,
  message_histories,
  client_fields,
  reports,
  business_info,
  business_membership,
} = require('../db/models');
const settingsService = require('../services/settings/settings.service');

module.exports = {
  async signup(req, res) {
    try {
      let dateTime = new Date();
      dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');

      const businessID = SettingsService.generateKey(20);
      const newUser = await users.create({
        firstname: req.body.firstname,
        lastname: req.body.lastname,
        username: `${req.body.firstname} ${req.body.lastname}`,
        email: req.body.email,
        password: bcrypt.hashSync(req.body.password, 10),
        created_at: dateTime,
        updated_at: dateTime,
        businessID,
      });
      const stripeData = await stripeService.createCustomer({
        email: req.body.email,
        firstname: req.body.firstname,
        lastname: req.body.lastname,
      });

      const business = await business_info.create({
        ID: businessID,
        user_id: newUser.id,
        business_name: newUser.username,
        customer_id: stripeData.id,
      });

      await business_membership.create({
        businessID: business.ID,
        priceID: 'price_1J4gE7IbbGL77O6KEyTotFxS',
        startDate: moment(dateTime),
        endDate: moment(dateTime).add(1, 'month'),
        state: 'active',
      });

      const defaultWaitlistSetting = await waitlist_setting.findOne({
        where: {
          user_id: 0,
        },
        raw: true,
      });
      defaultWaitlistSetting.PublicWaitlistUrl = businessID;
      defaultWaitlistSetting.user_id = newUser.id;
      delete defaultWaitlistSetting.ID;
      await waitlist_setting.create(defaultWaitlistSetting);
      const defaultBookingSettings = await booking_setting.findOne({
        where: {
          user_id: 0,
        },
        raw: true,
      });
      defaultBookingSettings.PublicBookingUrl = businessID;
      defaultBookingSettings.user_id = newUser.id;
      delete defaultBookingSettings.ID;
      await booking_setting.create({
        ...defaultBookingSettings,
      });

      const token = jwt.sign({ id: newUser.dataValues.id }, config.secret, {
        expiresIn: 172800, // 1 hours
      });

      // send email
      const emailData = {
        template: 'welcome',
        message: {
          from: 'info@avamgt.com',
          to: req.body.email,
        },
        locals: {
          name: req.body.firstname,
        },
      };
      await emailService.sendEmail(emailData);
      //
      res.status(200).send({
        success: true,
        accessToken: token,
        result: newUser,
      });
    } catch (e) {
      res.status(500).send({ message: e });
    }
  },
  // the function that called when managers signup;
  async managersignup(req, res) {
    try {
      let dateTime = new Date();
      dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');

      const user = await getResultQuery(
        `select t1.* from managers as t0 right join users as t1 on t0.user_id = t1.id where t0.ID = '${req.body.manager_id}'`,
      );
      const newUser = await users.create({
        username: req.body.name,
        email: req.body.email,
        password: bcrypt.hashSync(req.body.password, 10),
        role: 'manager',
        businessID: user[0].businessID,
        created_at: dateTime,
        updated_at: dateTime,
      });

      await managers.update(
        { ...req.body, is_sign_up: 'true' },
        {
          where: {
            ID: req.body.manager_id,
          },
        },
      );
      // make a token
      const token = jwt.sign({ id: newUser.dataValues.id }, config.secret, {
        expiresIn: 172800, // 1 hours
      });

      res.status(200).send({
        success: true,
        accessToken: token,
        result: newUser,
      });
    } catch (e) {
      res.status(500).send({ message: e });
    }
  },

  /* the function that called when managers signup; */
  async resourcesignup(req, res) {
    try {
      let dateTime = new Date();
      dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');

      const user = await getResultQuery(
        `select t1.* from resources as t0 right join users as t1 on t0.user_id = t1.id where t0.ID = '${req.body.resource_id}'`,
      );

      const newUser = await users.create({
        username: req.body.name,
        email: req.body.email,
        password: bcrypt.hashSync(req.body.password, 10),
        role: 'resource',
        businessID: user[0].businessID,
        created_at: dateTime,
        updated_at: dateTime,
      });

      await resources.update(
        { ...req.body, is_sign_up: 'true' },
        {
          where: {
            ID: req.body.resource_id,
          },
        },
      );
      // make a token
      const token = jwt.sign({ id: newUser.dataValues.id }, config.secret, {
        expiresIn: 172800, // 1 hours
      });

      res.status(200).send({
        success: true,
        accessToken: token,
        result: newUser,
      });
    } catch (e) {
      res.status(500).send({ message: e });
    }
  },

  async signin(req, res) {
    try {
      const user = await users.findOne({ where: { email: req.body.email } });
      if (!user) {
        return res.status(200).send({
          success: false,
          result: {
            tag: 'email',
            message: 'This email does not exist',
          },
        });
      }
      // const admin_id = await settingsService.getAdminId(user.id);
      // const business = await settingsService.getBusiness(admin_id);
      // if (!business.business_state) {
      //   return res.status(200).send({
      //     success: false,
      //     result: {
      //       tag: 'email',
      //       message: 'Your business blocked by avamgt system admin.',
      //     },
      //   });
      // }

      const passwordIsValid = bcrypt.compareSync(req.body.password, user.password);

      if (!passwordIsValid)
        return res.status(200).send({
          success: false,
          result: {
            tag: 'password',
            message: 'Password is wrong',
          },
        });

      const token = jwt.sign({ id: user.id }, config.secret, {
        expiresIn: 172800, // 1 hours
      });

      // update last login timestamp
      const dateTime = moment(new Date()).format('YYYY-MM-DD HH:mm:ss');
      await users.update({ last_login: dateTime }, { where: { id: user.id } });

      return res.status(200).send({
        success: true,
        result: user,
        accessToken: token,
      });
    } catch (e) {
      console.log(e);
      return res.status(500).send({ message: e });
    }
  },

  async me(req, res) {
    try {
      const user = await users.findOne({
        where: { id: req.user.id },
      });

      if (!user) return res.status(400).send({ message: 'User Not Found!' });

      const token = jwt.sign({ id: user.id }, config.secret, {
        expiresIn: 172800, // 1 hour
      });

      res.status(200).send({
        success: true,
        result: user,
        accessToken: token,
      });
    } catch (e) {
      res.status(500).send({ message: e });
    }
  },

  // function that manager is exist or manager have already signup
  async confirmbyid(req, res) {
    try {
      const manager = await managers.findOne({
        where: { id: req.body.id },
      });
      if (!manager) {
        res.status(200).send({
          success: false,
          result: 'manager not found',
        });
      }
      const user = await users.findOne({
        where: { email: manager.email },
      });
      // result:manager is data that using set the email field and name field in managersingup page(invite)
      if (user == null) {
        res.status(200).send({
          success: true,
          result: manager,
        });
      } else {
        res.status(200).send({
          success: false,
          result: 'manager already signup',
        });
      }
    } catch (e) {
      res.status(500).send({ message: e });
    }
  },
  // function that manager is exist or manager have already signup
  async resource_confirmbyid(req, res) {
    try {
      const resource = await resources.findOne({
        where: { id: req.body.id },
      });
      if (!resource) {
        res.status(200).send({
          success: false,
          result: 'resource not found',
        });
      }
      const user = await users.findOne({
        where: { email: resource.email },
      });
      // result:manager is data that using set the email field and name field in managersingup page(invite)
      if (user == null) {
        res.status(200).send({
          success: true,
          result: resource,
        });
      } else {
        res.status(200).send({
          success: false,
          result: 'resource already signup',
        });
      }
    } catch (e) {
      res.status(500).send({ message: e });
    }
  },

  async forgot(req, res) {
    try {
      const user = await users.findOne({ where: { email: req.body.email } });

      if (!user)
        return res.status(200).send({
          success: false,
          result: {
            tag: 'email',
            message: 'This email does not exist',
          },
        });

      const token = jwt.sign({ id: user.id }, config.secret, {
        expiresIn: 172800, // 48 hours
      });

      // send email
      const emailData = {
        template: 'reset_password',
        message: {
          from: 'info@avamgt.com',
          to: req.body.email,
        },
        locals: {
          name: user.firstname,
          token,
        },
      };
      await emailService.sendEmail(emailData);

      res.status(200).send({
        success: true,
        message: 'Check your mail box further proceeding',
      });
    } catch (e) {
      res.status(500).send({ message: e });
    }
  },

  async tokenValidation(req, res) {
    try {
      if (req.user) res.status(200).send({ success: true });
    } catch (e) {
      res.status(500).send({ message: e });
    }
  },

  async resetPassword(req, res) {
    try {
      const user = await users.findOne({ where: { id: req.user.id } });

      await users.update({ password: bcrypt.hashSync(req.body.password, 10) }, { where: { id: user.id } });

      // send email
      const emailData = {
        template: 'password_changed',
        message: {
          from: 'info@avamgt.com',
          to: user.email,
        },
        locals: {
          name: user.firstname,
        },
      };
      await emailService.sendEmail(emailData);

      res.status(200).send({
        success: true,
        message: 'Your password was successfully changed',
      });
    } catch (e) {
      res.status(500).send({ message: e });
    }
  },

  async getBusinessByWaitlist(req, res) {
    const business = await getResultQuery(`SELECT t1.* FROM waitlist_settings AS t0
    LEFT JOIN business_infos AS t1 ON t0.user_id = t1.user_id
    WHERE PublicWaitlistUrl = '${req.params.UrlNode}' LIMIT 1`);
    if (business.length == 0)
      res.status(200).send({
        success: false,
      });
    else {
      const waitlists = await getResultQuery(`
      SELECT t0.id,t0.wait_time,t1.name, t0.order_num FROM waitlists AS t0 
       INNER JOIN customers AS t1 ON t0.customer_id = t1.id
       WHERE t0.user_id = ${business[0].user_id} AND t0.serve_time IS NULL AND t0.is_show = 1 ORDER BY t0.order_num`);
      res.status(200).send({
        success: true,
        result: { ...business[0], waiting: waitlists },
      });
    }
  },
  async getBusinessByBooking(req, res) {
    const business = await getResultQuery(`SELECT t1.* FROM booking_settings AS t0
    LEFT JOIN business_infos AS t1 ON t0.user_id = t1.user_id
    WHERE PublicBookingUrl = '${req.params.UrlNode}' LIMIT 1`);
    if (business.length == 0)
      res.status(200).send({
        success: false,
      });
    else {
      const bookings = await getResultQuery(`
      SELECT t1.*,t0.* FROM bookings AS t0 
       INNER JOIN customers AS t1 ON t0.customer_id = t1.id
       WHERE t0.user_id = ${business[0].user_id}`);
      res.status(200).send({
        success: true,
        result: { ...business[0], booking: bookings },
      });
    }
  },
  async getBusinessByAppointmentKey(req, res) {
    const business = await getResultQuery(`SELECT t2.* FROM bookings AS t0
    LEFT JOIN users AS t1 ON t0.user_id = t1.id
    LEFT JOIN business_infos AS t2 ON t1.businessID = t2.ID
    WHERE appointment_key = '${req.params.key}' `);
    if (business.length === 0) {
      res.status(200).send({
        success: false,
      });
    } else {
      res.status(200).send({
        success: true,
        result: business[0],
      });
    }
  },
  async cotactToBusiness(req, res) {
    try {
      const emailData = {
        template: 'contact',
        message: {
          from: 'info@avamgt.com',
          to: 'info@avamgt.com',
        },
        locals: {
          name: req.body.name,
          email: req.body.email,
          phone: req.body.phone,
          message: req.body.message,
        },
      };
      await emailService.sendEmail(emailData);
      res.status(200).send({
        success: true,
      });
    } catch (e) {
      res.status(400).json(ResponseFormat.error(e, 'Something went wrong when send message to business', 'error'));
    }
  },

  async updateProfile(req, res) {
    try {
      let formData = {};
      if (req.params.type === 'form') {
        formData = {
          firstname: req.body.firstname,
          lastname: req.body.lastname,
          email: req.body.email,
          username: `${req.body.firstname} ${req.body.lastname}`,
        };
      } else if (req.params.type === 'avatar') {
        if (req.body.img_data === 'delete') {
          formData = {
            avatarUrl: null,
          };
        } else {
          formData = {
            avatarUrl: req.file.path,
          };
        }
      }

      await users.update(formData, { where: { id: req.user.id } });
      const user = await users.findOne({ where: { id: req.user.id } });
      return res.status(200).send({ success: true, result: user });
    } catch (e) {
      return res.status(400).json(ResponseFormat.error(e, 'Network Errors', 'error'));
    }
  },
  async closeAccount(req, res) {
    await alert_setting.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await booking_setting.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await bookings.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await waitlists.destroy({
      where: {
        user_id: req.user.id,
      },
    });
    await waitlist_setting.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await client_fields.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await managers.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await services.destroy({
      where: {
        user_id: req.user.id,
      },
    });
    await resources.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await localization.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await customers.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await message_templates.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await customers
      .findAll({
        where: {
          user_id: req.user.id,
        },
      })
      .then(async (customers) => {
        await Promise.all(
          customers.map(async (customer) => {
            await customer_meta.destroy({
              where: {
                customerId: customer.id,
              },
            });
          }),
        );
      });

    await business_info
      .findOne({
        where: {
          user_id: req.user.id,
        },
      })
      .then(async (business) => {
        await message_histories.destroy({
          where: {
            business_id: business.ID,
          },
        });
        await users
          .findAll({
            where: {
              businessID: business.ID,
            },
          })
          .then(async (obj) => {
            await Promise.all(
              obj.map(async (user) => {
                await messages.destroy({
                  where: {
                    [Op.or]: [{ sender_id: user.id }, { receiver_id: user.id }],
                  },
                });
              }),
            );
          });

        await users.destroy({
          where: {
            businessID: business.ID,
          },
        });
      });

    await business_info.destroy({
      where: {
        user_id: req.user.id,
      },
    });

    await sales
      .findAll({
        where: {
          user_id: req.user.id,
        },
        raw: true,
      })
      .then(async (obj) => {
        await Promise.all(
          obj.map(async (sale) => {
            await sale_datas.destroy({
              where: {
                sale_id: sale.id,
              },
            });
            await sales_sequence.destroy({
              where: {
                sale_id: sale.id,
              },
            });
          }),
        );
      });
    await sales.destroy({
      where: {
        user_id: req.user.id,
      },
    });
    await tasks
      .findAll({
        where: {
          user_id: req.user.id,
        },
      })
      .then(async (obj) => {
        await Promise.all(
          obj.map(async (task) => {
            await task_descriptions
              .findAll({
                where: {
                  task_id: task.id,
                },
              })
              .then(async (descriptions) => {
                await Promise.all(
                  descriptions.map(async (description) => {
                    await reports.destroy({
                      where: {
                        description_id: description.id,
                      },
                    });
                    await description_resources.destroy({
                      where: {
                        description_id: description.id,
                      },
                    });
                  }),
                );
              });
            await task_descriptions.destroy({
              where: {
                task_id: task.id,
              },
            });
          }),
        );
      });

    await tasks.destroy({
      where: {
        user_id: req.user.id,
      },
    });
    res.status(200).send({
      success: true,
    });
  },
};
