const fs = require('fs');
const moment = require('moment');
const db = require('../../db/models');
//import the manager table
const managers = db.managers;
const business_membership = db.business_membership;
const price_info = db.price_info;
const resources = db.resources;
const services = db.services;
const clientFields = db.client_fields;
const waitlistSetting = db.waitlist_setting;
const businessInfos = db.business_info;
const localizationSettings = db.localization;
const bookingSetting = db.booking_setting;
const AlertSettings = db.alert_setting;
const users = db.users;
// console.log("----------------------$$-------"+users+"-----------------------------")

const BaseService = require('../base.service');

const getResultQuery = require('../../core/util').getResultQuery;

class SettingsService extends BaseService {
  constructor() {
    super();
    this.dateTime = moment(new Date()).format('YYYY-MM-DD HH:mm:ss');
  }

  async createResource(data) {
    var tmpId = await this.getAdminId(data.body.user_id);
    // console.log(data.user);
    let user = await users.findOne({
      where: {
        id: data.body.user_id,
      },
    });
    try {
      let resource = await resources.findAll({
        where: {
          email: data.body.email,
        },
      });
      let manager = await managers.findAll({
        where: {
          email: data.body.email,
        },
      });

      if (resource.length || manager.length) {
        return 'exist';
      }

      let formData = {
        ID: this.generateKey(10),
        user_id: tmpId,
        name: data.body.name,
        display_name: data.body.display_name,
        category_name: data.body.category_name,
        email: data.body.email,
        phone: data.body.phone,
        img_path: data.file ? data.file.path : '',
        description: data.body.description,
        created_at: this.dateTime,
        updated_at: this.dateTime,
        working_hour: data.body.workingHour,
        serviceProvide: data.body.serviceProvide,
        working_data: data.body.workingData,
      };

      // console.log(user);
      if (user.role == 'manager') {
        formData.manager_id = data.user.id;
      }

      let newResource = await resources.create(formData);
      return newResource;
    } catch (e) {
      console.log(e);
      return false;
    }
  }

  async updateResource(data) {
    try {
      const resource = await resources.findOne({
        where: {
          ID: data.params.id,
        },
      });

      if (resource.is_sign_up === 'true') {
        await users.update(
          { ...data.body, username: data.body.name },
          {
            where: {
              username: resource.name,
              email: resource.email,
            },
          },
        );
      }

      const updateData = {
        ...data.body,
        img_path: data.file ? data.file.path : resource.img_path,
        updated_at: this.dateTime,
        working_hour: data.body.workingHour,
        serviceProvide: data.body.serviceProvide,
        working_data: data.body.workingData,
      };

      return await resources.update(updateData, {
        where: {
          ID: data.params.id,
        },
      });
    } catch (e) {
      return false;
    }
  }

  async updateResourceAvailable(data) {
    try {
      const updateData = { available: data.body.available, updated_at: this.dateTime };
      return await resources.update(updateData, {
        where: {
          ID: data.body.ID,
        },
      });
    } catch (e) {
      return false;
    }
  }

  async createService(data) {
    try {
      
      console.log(data.body,"service got");
            const insertData = {
        // ...data.body,
        img_data : data.body.img_data,
        color: data.body.color,
        name: data.body.name,
        display_name: data.body.display_name,
        category_name: data.body.category_name,
        email: data.body.email,
        phone: data.body.phone,
        description: data.body.description,
        img_path: data.file ? data.file.path : '',
        user_id: data.params.id,
        created_at: this.dateTime,
        updated_at: this.dateTime,
      };

      return await services.create(insertData);
    } catch (e) {
      console.log(e);
      return false;
    }
  }

  async updateService(data) {
    
    try {
      let updateData = null;
      if (data.file)
        updateData = {
          // ...data.body,
          img_data : data.body.img_data,
          color: data.body.color,
          name: data.body.name,
          display_name: data.body.display_name,
          category_name: data.body.category_name,
          email: data.body.email,
          phone: data.body.phone,
          description: data.body.description,
          img_path: data.file.path,
          updated_at: this.dateTime,
        };
      else updateData = { ...data.body, updated_at: this.dateTime };

      await services.update(updateData, {
        where: {
          id: data.params.id,
        },
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  //the function that create the manager
  async createManager(data) {
    try {
      let manager = await managers.findOne({
        where: {
          email: data.body.email,
        },
      });
      let resource = await resources.findOne({
        where: {
          email: data.body.email,
        },
      });
      //in case manager was exist in managers
      if (manager || resource) {
        return 'exits manager';
      }
      let newManager = await managers.create({
        ID: this.generateKey(10),
        user_id: data.params.id,
        name: data.body.name,
        email: data.body.email,
        is_sign_up: '',
      });
      return newManager;
    } catch (e) {
      console.log(e);
      return false;
    }
  }
  async createClientField(data) {
    const tmpId = await this.getAdminId(data.user_id);
    try {
      let newField = clientFields.create({
        ID: this.generateKey(10),
        user_id: tmpId,
        name: data.name,
        enable: '0',
        label: data.label,
        type: data.type,
        placeholder: data.placeholder,
        options: data.options,
        defaultValue: data.defaultValue,
        ordering: data.ordering,
        PORV: data.PORV,
        for: data.for,
        is_required: data.is_required,
        is_multiple: data.is_multiple,
        is_add_option: data.is_add_option,
        is_pre_select: data.is_pre_select,
      });
      return newField;
    } catch (e) {
      console.log(e);
    }
  }
  async updateClientField(data) {
    try {
      await clientFields.update(
        { ...data.body },
        {
          where: {
            ID: data.body.ID,
          },
        },
      );
      let updateField = await clientFields.findOne({
        where: {
          ID: data.body.ID,
        },
      });
      return updateField;
    } catch (e) {
      console.log(e);
    }
  }
  async updateWaitListSetting(data) {
    const tmpId = await this.getAdminId(data.user_id);
    try {
      let WaitListSetting = await waitlistSetting.findOne({
        where: {
          user_id: tmpId,
        },
      });
      if (WaitListSetting) {
        await waitlistSetting.update(
          { ...data },
          {
            where: {
              user_id: tmpId,
            },
          },
        );
      } else {
        await waitlistSetting.create({
          location_name: data.location_name,
          limit_max_waiting: data.limit_max_waiting,
          limit_max_wait_number: data.limit_max_wait_number,
          reject_duplicates: data.reject_duplicates,
          reject_flagged: data.reject_flagged,
          serving: data.serving,
          waiting: data.waiting,
          default_serve_duration: data.default_serve_duration,
          default_serve_duration_type: data.default_serve_duration_type,
          number_of_serve_people: data.number_of_serve_people,
          service_duration: data.service_duration,
          call_business: data.call_business,
          status_indicator: data.status_indicator,
          hide_cancel: data.hide_cancel,
          user_id: tmpId,
          PublicWaitlistUrl: data.PublicWaitlistUrl,
        });
      }
      WaitListSetting = await waitlistSetting.findOne({
        where: {
          user_id: tmpId,
        },
      });
      return WaitListSetting;
    } catch (e) {
      console.log(e);
    }
  }
  async updateBusinessInfoSetting(data) {
  
    // console.log(data.body.ID,"ASDss++++++++++++++++++++++++++++++++++++++++++++++s",data.body.user_id);
    const tmpId = await this.getAdminId(data.body.user_id);
    try {
      const businessInfo = await businessInfos.findOne({
        where: {
          ID: data.body.ID,
        },
      });

      var formData = {};
      // if (data.params.type == 'name') {
        formData = {
          ...formData,
          business_name: data.body.business_name,
        };
      // }
      //  else if (data.params.type === 'logo') {
      //   if (data.body.img_data === 'delete') {
      //     formData = {
      //       ...formData,
      //       business_logo: null,
      //     };
      //   } else {
      //     formData = {
      //       ...formData,
      //       business_logo: data.file ? data.file.path : businessInfo.business_logo,
      //     };
      //   }
      // } else if (data.params.type === 'color') {
      //   formData = {
      //     ...formData,
      //     business_color: data.body.business_color,
      //   };
      // } else if (data.params.type === 'sale_state') {
      //   formData = {
      //     ...formData,
      //     sale_state: data.body.sale_state,
      //   };
      // }

      if (businessInfo) {
        await businessInfos.update(formData, {
          where: {
            ID: data.body.ID,
          },
        });
      } else {
        await businessInfos.create({ ...formData, user_id: tmpId });
      }

      return await businessInfos.findOne({
        where: {
          ID: data.body.ID,
        },
      });
    } catch (e) {
      return false;
    }
  }
  async updateLocalizationSetting(data) {
    const tmpId = await this.getAdminId(data.user_id);
    try {
      let localizationSetting = await localizationSettings.findOne({
        where: {
          user_id: tmpId,
        },
      });
      if (localizationSetting) {
        await localizationSettings.update(
          { ...data },
          {
            where: {
              user_id: tmpId,
            },
          },
        );
      } else {
        await localizationSettings.create({
          timezone: data.timezone,
          user_id: tmpId,
        });
      }
      localizationSetting = await localizationSettings.findOne({
        where: {
          user_id: tmpId,
        },
      });
      return localizationSetting;
    } catch (e) {
      console.log(e);
    }
  }

  async updateBookingSettings(data) {
    const tmpId = await this.getAdminId(data.user_id);
    try {
      let bookingSettings = await bookingSetting.findOne({
        where: {
          user_id: tmpId,
        },
      });
      if (bookingSettings) {
        await bookingSetting.update(
          { ...data },
          {
            where: {
              user_id: tmpId,
            },
          },
        );
      } else {
        await bookingSetting.create({
          SpotsPerTimeSlot: data.SpotsPerTimeSlot,
          maxDuration: data.maxDuration,
          minDuration: data.minDuration,
          DefaultView: data.DefaultView,
          EndHour: data.EndHour,
          HidePast: data.HidePast,
          StartHour: data.StartHour,
          WeekStartDay: data.WeekStartDay,
          AllowCustomerCancelBooking: data.AllowCustomerCancelBooking,
          AllowCustomerRescheduleBooking: data.AllowCustomerRescheduleBooking,
          AllowStaffOverBookFullTimeSlot: data.AllowStaffOverBookFullTimeSlot,
          MaxAdvanceKind: data.MaxAdvanceKind,
          MaxAdvanceNumber: data.MaxAdvanceNumber,
          MaxBooking: data.MaxBooking,
          MinBooking: data.MinBooking,
          MinNoticeKind: data.MinNoticeKind,
          MinNoticeNumber: data.MinNoticeNumber,
          RejectDuplicate: data.RejectDuplicate,
          RejectFlagged: data.RejectFlagged,
          openingGeneralHours: data.openingGeneralHours,
          openingBookingHours: data.openingBookingHours,
          openingWaitListHours: data.openingWaitListHours,
          CalendarData: data.CalendarData,
          user_id: tmpId,
          PublicBookingUrl: data.PublicBookingUrl,
        });
      }
      bookingSettings = await bookingSetting.findOne({
        where: {
          user_id: tmpId,
        },
      });
      return bookingSettings;
    } catch (e) {
      console.log(e);
    }
  }
  async updateAlertSetting(data) {
    let result = await Promise.all([this.getAdminId(data.user_id)]).then(async (value) => {
      const tmpId = value[0];
      try {
        let AlertSetting = await AlertSettings.findOne({
          where: {
            user_id: tmpId,
            key: data.key,
          },
        });
        if (AlertSetting) {
          await AlertSettings.update(
            {
              enable: data.enable,
              data_field: data.data_field,
            },
            {
              where: {
                user_id: tmpId,
                key: data.key,
              },
            },
          );
        } else {
          await AlertSettings.create({
            // id:this.generateKey(),
            key: data.key,
            data_field: data.data_field,
            user_id: tmpId,
            enable: data.enable,
          });
        }
        AlertSetting = await AlertSettings.findOne({
          where: {
            user_id: tmpId,
            key: data.key,
          },
        });
        return AlertSetting;
      } catch (e) {
        console.log(e);
      }
    });
    return result;
  }

  async getBusiness(id) {
    let businessInfo = await businessInfos.findOne({
      where: { user_id: id },
      include: [
        {
          model: business_membership,
          where: {
            state: 'active',
          },
          include: [price_info],
          required: false,
        },
      ],
    });
    return businessInfo;
  }

  async getAlertSetting(user_id) {
    let AlertSetting = await getResultQuery(
      'SELECT IF(t1.id IS NULL,t0.value,t1.data_field)AS data_field ,IF(t1.id IS NULL,t0.enable,t1.enable)AS `enable`, t0.key FROM alert_settings_default AS t0 LEFT JOIN alert_settings AS t1 ON t1.key = t0.key AND t1.user_id = ' +
        user_id +
        ' ',
    );
    return AlertSetting;
  }

  async getAdminId(param) {
    const user = await users.findOne({
      where: {
        id: param,
      },
    });
    // console.log(user,"++++++++++++++++++");
    if (user && user.role == 'manager') {
      const tmp = await managers.findOne({
        where: {
          name: user.username,
          email: user.email,
        },
      });
      return tmp.user_id;

    } 
    else if (user.role == 'resource') {
      const tmp = await resources.findOne({
        where: {
          name: user.username,
          email: user.email,
        },
      });
      return tmp.user_id;
    } else {
      return user.id;
    }
  }

  async getUser(id) {
    const user = await users.findOne({
      where: {
        id: id,
      },
      raw: true,
    });
    // console.log("____________________",user,"____________________")

    return user;
  }

  async getFilterTime(type, startDate) {
    if (startDate == 'Today') {
      startDate = moment(new Date()).format('dddd');
    }
    var filterTime = { start: '', end: '' };
    var generalDate = new Date();
    switch (type) {
      case 'Daily': {
        filterTime['start'] = moment(generalDate).format('YYYY-MM-DD');
        filterTime['end'] = moment(generalDate).format('YYYY-MM-DD');
        break;
      }
      case 'Weekly': {
        var tempGeneralDate = generalDate;
        while (moment(tempGeneralDate).format('dddd') != startDate) {
          tempGeneralDate = moment(tempGeneralDate).subtract(1, 'days');
        }
        filterTime['start'] = moment(tempGeneralDate).format('YYYY-MM-DD');
        tempGeneralDate = generalDate;
        while (moment(tempGeneralDate).add(1, 'days').format('dddd') != startDate) {
          tempGeneralDate = moment(tempGeneralDate).add(1, 'days');
        }
        filterTime['end'] = moment(tempGeneralDate).format('YYYY-MM-DD');
        break;
      }
      case 'Monthly': {
        var month = moment(tempGeneralDate).format('M');
        var year = moment(tempGeneralDate).format('YYYY');
        filterTime['start'] = moment(tempGeneralDate).format('YYYY-MM') + '-1';
        filterTime['end'] = moment(new Date(year, month, 0)).format('YYYY-MM-DD');
        break;
      }
      default: {
        break;
      }
    }
    return filterTime;
  }
  async addAction(type, admin_id) {
    let business = await businessInfos.findOne({
      where: {
        user_id: admin_id,
      },
      raw: true,
    });
    let updateData = {};
    updateData[type] = db.sequelize.literal(`${type}+1`);
    updateData['total_add_time'] = db.sequelize.literal(`total_add_time+1`);
    await businessInfos.update(updateData, {
      where: {
        ID: business.ID,
      },
    });
    let result = await businessInfos.findOne({
      where: {
        ID: business.ID,
      },
    });
    return result;
  }
}
module.exports = new SettingsService();
