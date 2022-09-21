const moment = require('moment');
const db = require('../db/models');
const { ResponseFormat } = require('../core');

const { business_membership, price_info, users, resources, managers, services, message_templates } = db;

const clientFields = db.client_fields;
const waitlistSettings = db.waitlist_setting;
const businessInfos = db.business_info;
const localizationSettings = db.localization;
const bookingSetting = db.booking_setting;
const settingsService = require('../services/settings/settings.service');
const emailService = require('../services/email/email.service');
const stripeService = require('../services/stripe/stripe.service');

module.exports = {
async updateWebSetting(req,res){

},

  async getResources(req, res) {
    // console.log(req.params);
    // console.log(req.body);
    // console.log(req.query);
    // const tmpId = await settingsService.getAdminId(req.query.id);
    const tmpId = await settingsService.getAdminId(req.params.id);

    const user = await users.findOne({
      where: {
        // id: req.query.id,
        id:req.params.id
      },
    });
    const where = { user_id: tmpId };
    if (user.role === 'manager') {
      // where.manager_id = req.query.id;
      where.manager_id = req.params.id;

    }
    try {
      const resourceData = await resources.findAll({
        where,
      });
      res.status(200).send({
        success: true,
        result: resourceData,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async addResource(req, res) {
    // console.log(req.body)
    const admin_id = await settingsService.getAdminId(req.body.user_id);
    const business = await businessInfos.findOne({
      where: {
        user_id: admin_id,
      },
    });
    try {
      const newResource = await settingsService.createResource(req);
      if (newResource == 'exist') {
        res.status(200).send({
          message: 'exist',
        });
      } else if (newResource.email) {
        if(business){
          const message = `Hi, ${newResource.name} you invited in ${business.business_name} as a resource. Follow this link to accept! ${req.headers.referer}invite_resource/${newResource.ID} `;
          const emailData = {
            template: 'invite',
            message: {
              from: 'info@avamgt.com',
              to: newResource.email,
            },
            locals: {
              subject: `You invited in ${business.business_name}`,
              message,
            },
          };
          emailService.sendEmail(emailData);
        }
        res.status(200).send({
          success: true,
          result: newResource,
        });
      }
    } catch (e) {
      console.log(e);
    }
  },

  async updateResource(req, res) {
    // console.log(req.body)
    try {
      await settingsService.updateResource(req);
      const resourceData = await resources.findOne({
        where: { ID: req.params.id },
      });
      res.status(200).send({
        success: true,
        result: resourceData,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async updateResourceAvailable(req, res) {
    try {
      await settingsService.updateResourceAvailable(req);
      const resourceData = await resources.findOne({
        where: { ID: req.body.ID },
      });
      res.status(200).send({
        success: true,
        result: resourceData,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async getResourceByResource(req, res) {
    // console.log(req.body)
    // console.log(req.params)
    // console.log(req.query)

    try {
      const user = await users.findOne({
        where: {
          id: req.params.user_id,
        },
      });
      const resourceData = await resources.findOne({
        where: {
          name: user.username,
          email: user.email,
        },
      });
      res.status(200).send({
        success: true,
        result: resourceData,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async deleteResource(req, res) {
    try {
      const resource = await resources.findOne({
        where: {
          ID: req.params.id,
        },
      });
      await users.destroy({
        where: {
          username: resource.name,
          email: resource.email,
        },
      });
      await resources.destroy({
        where: { ID: req.params.id },
      });

      res.status(200).send({
        success: true,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async getServices(req, res) {
    try {
      const adminId = await settingsService.getAdminId(req.params.id);
      const serviceData = await services.findAll({
        where: {
          user_id: adminId,
        },
      });

      res.status(200).send({
        success: true,
        result: serviceData,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async addService(req, res) {
    // console.log(req.body,"+++++++++++++++++++++++++++");
    try {
      const newResource = await settingsService.createService(req);

      res.status(200).send({
        success: true,
        result: newResource,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async updateService(req, res) {
    console.log(req.params.id);
    try {
      await settingsService.updateService(req);
      const serviceData = await services.findAll({
        where: { user_id: req.params.id },
      });

      res.status(200).send({
        success: true,
        result: serviceData,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async deleteService(req, res) {
    try {
      await services.destroy({
        where: { id: req.params.id },
      });

      res.status(200).send({
        success: true,
      });
    } catch (e) {
      console.log(e);
    }
  },
  // get the manager's data function
  async getManager(req, res) {
    try {
      const ManagerData = await managers.findAll({
        where: {
          user_id: req.params.id,
        },
      });
      res.status(200).send({
        success: true,
        result: ManagerData,
      });
    } catch (e) {
      console.log(e);
    }
  },
  // add the manager function
  async addManager(req, res) {
    console.log(req.body);
    const business = await businessInfos.findOne({
      where: {
        user_id: req.params.id,
      },
    });
    try {
      const newManager = await settingsService.createManager(req);
      if (newManager === 'exits manager') {
        return res.status(200).send({
          message: 'exist',
        });
      }
      const message = `Hi, ${newManager.name} you invited in ${business.business_name} as a manager. Follow this link to accept! ${req.headers.referer}invite/${newManager.ID} `;
      const emailData = {
        template: 'invite',
        message: {
          from: 'info@avamgt.com',
          to: newManager.email,
        },
        locals: {
          subject: `You invited in ${business.business_name}`,
          message,
        },
      };
      emailService.sendEmail(emailData);
      return res.status(200).send({
        success: true,
        result: newManager,
      });
    } catch (e) {
      return res.status(400).json(ResponseFormat.error(e, 'Network Error', 'error'));
    }
  },
  // manager's update function
  async updateManager(req, res) {
    let manager = await managers.findOne({
      where: {
        ID: req.body.ID,
      },
    });
    if (manager) {
      await users.update(
        { ...req.body, email: req.body.email, username: req.body.name },
        {
          where: {
            email: manager.email,
          },
        },
      );
    }
    await managers.update(
      { ...req.body, email: req.body.email, name: req.body.name },
      {
        where: {
          ID: req.body.ID,
        },
      },
    );
    manager = await managers.findOne({
      where: {
        ID: req.body.ID,
      },
    });
    res.status(200).send({
      success: true,
      result: manager,
    });
  },

  async deleteManager(req, res) {
    try {
      const manager = await managers.findOne({
        where: {
          ID: req.params.id,
        },
      });
      await users.destroy({
        where: {
          username: manager.name,
          email: manager.email,
        },
      });
      await managers.destroy({
        where: { ID: req.params.id },
      });

      res.status(200).send({
        success: true,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async addClientField(req, res) {
    const newClientField = await settingsService.createClientField(req.body);
    res.status(200).send({
      success: true,
      result: newClientField,
    });
  },
  async getClientField(req, res) {
    const tmpId = await settingsService.getAdminId(req.params.user_id);
    const clientField = await clientFields.findAll({
      where: {
        user_id: tmpId,
      },
      order: [['ordering', 'ASC']],
    });
    res.status(200).send({
      success: true,
      result: clientField,
    });
  },
  async updateClientField(req, res) {
    const updateClientField = await settingsService.updateClientField(req);
    res.status(200).send({
      success: true,
      result: updateClientField,
    });
  },
  async enableField(req, res) {
    let client_field_data = await clientFields.findOne({
      where: {
        ID: req.params.id,
      },
    });
    await clientFields.update(
      { enable: client_field_data.enable == '1' ? '0' : '1' },
      {
        where: {
          ID: req.params.id,
        },
      },
    );
    client_field_data = await clientFields.findOne({
      where: {
        ID: req.params.id,
      },
    });
    res.status(200).send({
      success: true,
      result: client_field_data,
    });
  },

  async deleteClientField(req, res) {
    try {
      await clientFields.destroy({
        where: { ID: req.params.id },
      });

      res.status(200).send({
        success: true,
        result: req.params.id,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async getWaitListSettings(req, res) {
    const tmpId = await settingsService.getAdminId(req.params.id);
    try {
      let WaitListSetting = await waitlistSettings.findOne({
        where: { user_id: tmpId },
      });
      if (!WaitListSetting) {
        WaitListSetting = await waitlistSettings.findOne({
          where: {
            ID: 1,
            user_id: 0,
          },
        });
      }
      res.status(200).send({
        success: true,
        result: WaitListSetting,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async updateWaitListSettings(req, res) {
    try {
      const WaitListSetting = await settingsService.updateWaitListSetting(req.body);
      res.status(200).send({
        success: true,
        result: WaitListSetting,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async ResetSettings(req, res) {
    const tmpId = await settingsService.getAdminId(req.params.id);
    // tmpId is user_id !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    const user = users.findOne({
      where: {
        id: req.body.user_id,
        password: req.body.password,
      },
    });
    if (user.name != undefined) {
      try {
        res.status(200).send({
          success: true,
        });
      } catch (e) {
        console.log(e);
      }
    } else {
      res.status(200).send({
        success: false,
        message: 'Password is incorrect!',
      });
    }
  },
  async ClearData(req, res) {
    const tmpId = await settingsService.getAdminId(req.params.id);
    // tmpId is user_id !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    const user = users.findOne({
      where: {
        id: req.body.user_id,
        password: req.body.password,
      },
    });
    if (user.name != undefined) {
      try {
        res.status(200).send({
          success: true,
        });
      } catch (e) {
        console.log(e);
      }
    } else {
      res.status(200).send({
        success: false,
        message: 'Password is incorrect!',
      });
    }
  },
  async DeleteWaitList(req, res) {
    const tmpId = await settingsService.getAdminId(req.params.id);
    // tmpId is user_id !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    const user = users.findOne({
      where: {
        id: req.body.user_id,
        password: req.body.password,
      },
    });
    if (user.name != undefined) {
      try {
        res.status(200).send({
          success: true,
        });
      } catch (e) {
        console.log(e);
      }
    } else {
      res.status(200).send({
        success: false,
        message: 'Password is incorrect!',
      });
    }
  },

  async getBookingSettings(req, res) {
    const tmpId = await settingsService.getAdminId(req.params.id);
    try {
      let BookingSettings = await bookingSetting.findOne({
        where: { user_id: tmpId },
      });

      if (!BookingSettings) {
        BookingSettings = await bookingSetting.findOne({
          where: {
            ID: 1,
            user_id: 0,
          },
        });
      }
      res.status(200).send({
        success: true,
        result: BookingSettings,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async getFilterBookingSettings(req, res) {
    const tmpId = await settingsService.getAdminId(req.body.user_id);
    try {
      let BookingSettings = await bookingSetting.findOne({
        where: { user_id: tmpId },
      });
      if (!BookingSettings) {
        BookingSettings = await bookingSetting.findOne({
          where: {
            ID: 1,
            user_id: 0,
          },
        });
      }
      let filterDate;
      if (req.body.filterTime == undefined) {
        filterDate = await settingsService.getFilterTime(BookingSettings.DefaultView, BookingSettings.WeekStartDay);
      } else {
        filterDate = req.body.filterTime;
        if (req.body.currentView == 'month') {
          BookingSettings.DefaultView = 'Monthly';
        } else if (req.body.currentView == 'week') {
          BookingSettings.DefaultView = 'Weekly';
        } else if (req.body.currentView == 'day') {
          BookingSettings.DefaultView = 'Daily';
        }
      }
      const CalendarData = JSON.parse(BookingSettings.CalendarData);
      const tmpCalendarData = CalendarData.filter((element) => {
        const startTime = moment(filterDate.start, 'YYYY-MM-DD');
        const endTime = moment(filterDate.end, 'YYYY-MM-DD');
        const tmp = moment(`${element.Year}-${element.Month + 1} ${element.Date}`, 'YYYY-MM-DD');
        return moment(tmp).isBetween(
          moment(startTime).format('YYYY-MM-DD'),
          moment(endTime).format('YYYY-MM-DD'),
          null,
          '[]',
        );
      });
      BookingSettings.CalendarData = JSON.stringify(tmpCalendarData);
      res.status(200).send({
        success: true,
        result: BookingSettings,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async updateBookingSettings(req, res) {
    try {
      const BookingSettings = await settingsService.updateBookingSettings(req.body);
      res.status(200).send({
        success: true,
        result: BookingSettings,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async getAlertSetting(req, res) {
    const tmpId = await settingsService.getAdminId(req.params.id);
    try {
      const AlertSetting = await settingsService.getAlertSetting(tmpId);
      res.status(200).send({
        success: true,
        result: AlertSetting,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async updateAlertSetting(req, res) {
    try {
      const AlertSetting = await settingsService.updateAlertSetting(req.body);
      res.status(200).send({
        success: true,
        result: AlertSetting,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async addMessageTemplate(req, res) {
    const tmpId = await settingsService.getAdminId(req.user.id);
    try {
      const newTemplate = await message_templates.create({
        ...req.body,
        user_id: tmpId,
      });
      res.status(200).send({
        success: true,
        result: newTemplate,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async updateMessageTemplate(req, res) {
    try {
      await message_templates.update(
        { ...req.body },
        {
          where: {
            id: req.body.id,
          },
        },
      );
      const result = await message_templates.findOne({
        where: {
          id: req.body.id,
        },
      });
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async getMessageTemplate(req, res) {
    const tmpId = await settingsService.getAdminId(req.user.id);
    try {
      const templates = await message_templates.findAll({
        where: {
          user_id: tmpId,
        },
      });
      res.status(200).send({
        success: true,
        result: templates,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async getBusinessInfo(req, res) {
    try {
      const adminId = await settingsService.getAdminId(req.params.id);
      // console.log("----------------------",req.user.id,"----------------------")
      const businessInfo = await settingsService.getBusiness(adminId);
      return res.status(200).send({
        success: true,
        result: businessInfo,
      });
    } catch (e) {
      return res.status(400).json(ResponseFormat.error({}, 'Network Error', 'error'));
    }
  },
  async updateBusinessInfoSetting(req, res) {
    try {
      const businessInfo = await settingsService.updateBusinessInfoSetting(req);
      return res.status(200).send({
        success: true,
        result: businessInfo,
      });
    } catch (e) {
      return res.status(400).json(ResponseFormat.error(e, 'Network Error', 'error'));
    }
  },
  async getLocalizationSetting(req, res) {
    const tmpId = await settingsService.getAdminId(req.params.id);
    try {
      let localizationSetting = await localizationSettings.findOne({
        where: { user_id: tmpId },
      });
      if (!localizationSetting) {
        localizationSetting = await localizationSettings.findOne({
          where: {
            ID: 1,
            user_id: 0,
          },
        });
      }
      res.status(200).send({
        success: true,
        result: localizationSetting,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async updateLocalizationSetting(req, res) {
    try {
      const localizationSetting = await settingsService.updateLocalizationSetting(req.body);
      res.status(200).send({
        success: true,
        result: localizationSetting,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async createCheckoutSession(req, res) {
    const adminId = await settingsService.getAdminId(req.user.id);
    const business = await businessInfos.findOne({
      where: {
        user_id: adminId,
      },
    });
    const data = await stripeService.createCheckoutSession({ priceId: req.body.priceId, businessId: business.ID });
    res.status(200).send({
      success: true,
      result: data,
    });
  },
  async getPaymentHistory(req, res) {
    const admin_id = await settingsService.getAdminId(req.user.id);
    const business = await businessInfos.findOne({
      where: {
        user_id: admin_id,
      },
    });
    const data = await stripeService.getPaymentHistory(business.customer_id);
    res.status(200).send({
      success: true,
      result: data,
    });
  },
  async buyPlan(req, res) {
    try {
      const adminId = await settingsService.getAdminId(req.user.id);
      const business = await businessInfos.findOne({
        where: {
          user_id: adminId,
        },
      });
      const planInfo = await price_info.findOne({
        where: {
          priceID: req.body.priceId,
        },
      });
      let startDate;
      let endDate;
      if (planInfo.type === 'monthly') {
        startDate = moment().format('YYYY-MM-DD');
        endDate = moment().add(1, 'month').format('YYYY-MM-DD');
      } else {
        startDate = moment().format('YYYY-MM-DD');
        endDate = moment().add(1, 'year').format('YYYY-MM-DD');
      }
      await business_membership.update(
        {
          state: 'end',
        },
        {
          where: {
            businessID: business.ID,
          },
        },
      );
      const result = await business_membership.create({
        businessID: business.ID,
        priceID: req.body.priceId,
        startDate,
        endDate,
        state: 'active',
      });
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async getMembership(req, res) {
    try {
      const result = await business_membership.findOne({
        where: {
          businessID: req.body.businessID,
          state: 'active',
        },
        raw: true,
      });
      const price = await stripeService.getPrice(result.priceID);
      res.status(200).send({
        success: true,
        result: { ...result, price },
      });
    } catch (e) {
      res.status(500).send(e);
    }
  },
  async createSubscription(req, res) {
    const adminId = await settingsService.getAdminId(req.user.id);
    const business = await businessInfos.findOne({
      where: {
        user_id: adminId,
      },
    });
    try {
      const subscription = await stripeService.createSubscription(business.customer_id, req.body.priceId);
      res.send({
        success: true,
        result: {
          subscriptionId: subscription.id,
          clientSecret: subscription.latest_invoice.payment_intent.client_secret,
        },
      });
    } catch (e) {
      console.log(e);
    }
  },
};
