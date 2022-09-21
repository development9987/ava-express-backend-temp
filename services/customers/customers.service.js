const moment = require('moment');

const db = require('../../db/models');
const { Op } = require('sequelize');
const customers = db.customers;
const customer_meta = db.customer_meta;
const clientFields = db.client_fields;
const waitlists = db.waitlists;
const users = db.users;
const resources = db.resources;
const settingsService = require('../settings/settings.service');
const BaseService = require('../base.service');

class CustomersService extends BaseService {
  async createNewCustomer(data) {
    var admin_id = await settingsService.getAdminId(data.user_id);
    let dateTime = new Date();
    dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
    try {
      let newCustomer = await customers.create({
        user_id: admin_id,
        name: data.name,
        customer_group_id: data.customer_group_id,
        email: data.email,
        phone: data.phone,
        description: data.description,
        created_at: dateTime,
        updated_at: dateTime,
      });

      if (data.addition) {
        Object.getOwnPropertyNames(data.addition).map(async (key) => {
          await customer_meta.create({
            meta_key: key,
            meta_value: data.addition[key],
            customerId: newCustomer.id,
          });
        });
      }
      return newCustomer;
    } catch (e) {
      console.log(e);
      return false;
    }
  }

  async UpdateCustomer(data, customer_id) {
    var admin_id = await settingsService.getAdminId(data.user_id);
    let dateTime = new Date();
    dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
    try {
      let customer = await customers.update(
        {
          user_id: admin_id,
          name: data.name,
          customer_group_id: data.customer_group_id,
          email: data.email,
          phone: data.phone,
          description: data.description,
          updated_at: dateTime,
        },
        { where: { id: customer_id } },
      );
      await Promise.all(
        Object.getOwnPropertyNames(data.addition).map(async (key) => {
          customer_meta
            .findOne({
              where: {
                customerId: customer_id,
                meta_key: key,
              },
            })
            .then(async (row) => {
              if (row) {
                await customer_meta.update(
                  { meta_value: data.addition[key] },
                  {
                    where: {
                      customerId: customer_id,
                      meta_key: key,
                    },
                  },
                );
              } else {
                await customer_meta.create({
                  customerId: customer_id,
                  meta_key: key,
                  meta_value: data.addition[key],
                });
              }
            });
        }),
      );
      return customer;
    } catch (e) {
      return false;
    }
  }

  async getCustomerByUser(user_id) {
    try {
      let data = await customers.findAll({
        where: { user_id },
      });
      return data;
    } catch (e) {
      return false;
    }
  }

  async getCustomerByWaitlist(user_id) {
    var tmpId = await settingsService.getAdminId(user_id);
    var user = await users.findOne({
      where: {
        id: user_id,
      },
    });
    var whereCondition = {
      user_id: tmpId,
      is_show: !null,
      serve_time: null,
      priority: {[Op.or]: [null, 0]},
     
    };
    if (user.role === 'resource') {
      var resource = await resources.findOne({
        where: {
          name: user.username,
          email: user.email,
        },
      });
      if (resource) {
        whereCondition = {
          resource_id: resource.ID,
          is_show: !null,
          serve_time: null,
        };
      }
    }
    var include = [
      {
        model: customers,
        include: [
          {
            model: customer_meta,
            include: [clientFields],
          },
        ],
        required: true,
      },
    ];
    if (user.role === 'manager') {
      include.push({
        model: resources,
        include: [users],
        where: {
          manager_id: user.id,
        },
        required: true,
      });
    } else {
      include.push({
        model: resources,
        include: [users],
      });
    }
    try {
      var Data = [];
      await waitlists
        .findAll({
          include: include,
          where: whereCondition,
          order: [['order_num', 'ASC']],
        })
        .then((waits) => {
          Data = waits.map((wait) => {
            if (wait.customers[0] != null) {
              return Object.assign(
                {},
                {
                  id: wait.id,
                  user_id: wait.user_id,
                  serve_time: wait.serve_time,
                  wait_time: wait.wait_time,
                  order_num: wait.order_num,
                  customer_id: wait.customer_id,
                  resource_id: wait.resource_id,
                  service_id: wait.service_id,
                  booking_id: wait.booking_id,
                  name: wait.customers[0].name,
                  resource: wait.resource,
                  customer_group_id: wait.customers[0].customer_group_id,
                  email: wait.customers[0].email,
                  phone: wait.customers[0].phone,
                  description: wait.customers[0].description,
                  meta: wait.customers[0].customer_meta.map((meta_data) => {
                    if (meta_data['client_fields'][0] != undefined) {
                      return Object.assign(
                        {},
                        {
                          meta_key: meta_data.meta_key,
                          meta_value: meta_data.meta_value,

                          type: meta_data['client_fields'][0]['type'],
                        },
                      );
                    }
                  }),
                },
              );
            }
          });
        });

      Data = Data.filter((item) => item != null);
      return Data;
    } catch (e) {
      return false;
    }
  }

  
  async getCustomerByPriority(user_id) {
    var tmpId = await settingsService.getAdminId(user_id);
    var user = await users.findOne({
      where: {
        id: user_id,
      },
    });
    var whereCondition = {
      user_id: tmpId,
      is_show: !null,
      serve_time: null,
      priority:{
        [Op.gt]:0,
      },

    };
    if (user.role === 'resource') {
      var resource = await resources.findOne({
        where: {
          name: user.username,
          email: user.email,
        },
      });
      if (resource) {
        whereCondition = {
          resource_id: resource.ID,
          is_show: !null,
          serve_time: null,
        };
      }
    }
    var include = [
      {
        model: customers,
        include: [
          {
            model: customer_meta,
            include: [clientFields],
          },
        ],
        required: true,
      },
    ];
    if (user.role === 'manager') {
      include.push({
        model: resources,
        include: [users],
        where: {
          manager_id: user.id,
        },
        required: true,
      });
    } else {
      include.push({
        model: resources,
        include: [users],
      });
    }
    try {
      var Data = [];
      await waitlists
        .findAll({
          include: include,
          where: whereCondition,
          order: [['priority', 'DESC']],
        })
        .then((waits) => {
          // console.log(waits);
          Data = waits.map((wait) => {
            if (wait.customers[0] != null) {
              return Object.assign(
                {},
                {
                  id: wait.id,
                  user_id: wait.user_id,
                  serve_time: wait.serve_time,
                  wait_time: wait.wait_time,
                  order_num: wait.order_num,
                  priority: wait.priority,
                  customer_id: wait.customer_id,
                  resource_id: wait.resource_id,
                  service_id: wait.service_id,
                  booking_id: wait.booking_id,
                  name: wait.customers[0].name,
                  resource: wait.resource,
                  customer_group_id: wait.customers[0].customer_group_id,
                  email: wait.customers[0].email,
                  phone: wait.customers[0].phone,
                  description: wait.customers[0].description,
                  meta: wait.customers[0].customer_meta.map((meta_data) => {
                    if (meta_data['client_fields'][0] != undefined) {
                      return Object.assign(
                        {},
                        {
                          meta_key: meta_data.meta_key,
                          meta_value: meta_data.meta_value,

                          type: meta_data['client_fields'][0]['type'],
                        },
                      );
                    }
                  }),
                },
              );
            }
          });
        });

      Data = Data.filter((item) => item != null);
      return Data;
    } catch (e) {
      return false;
    }
  }


  async getCustomerByServe(user_id) {
    var tmpId = await settingsService.getAdminId(user_id);
    var user = await users.findOne({
      where: {
        id: user_id,
      },
    });
    var whereCondition = {
      user_id: tmpId,
      is_show: !null,
      [Op.not]: { serve_time: null },
    };
    if (user.role == 'resource') {
      var resource = await resources.findOne({
        where: {
          name: user.username,
          email: user.email,
        },
      });
      if (resource) {
        whereCondition = {
          resource_id: resource.ID,
          is_show: !null,
          [Op.not]: { serve_time: null },
        };
      }
    }
    var include = [
      {
        model: customers,
        include: [
          {
            model: customer_meta,
            include: [clientFields],
          },
        ],
        required: true,
      },
    ];
    if (user.role === 'manager') {
      include.push({
        model: resources,
        include: [users],
        where: {
          manager_id: user.id,
        },
        required: true,
      });
    } else {
      include.push({
        model: resources,
        include: [users],
      });
    }
    var Data = [];
    await waitlists
      .findAll({
        include: include,
        where: whereCondition,
      })
      .then((waits) => {
        Data = waits.map((wait) => {
          if (wait.customers[0] != undefined) {
            return Object.assign(
              {},
              {
                id: wait.id,
                user_id: wait.user_id,
                serve_time: wait.serve_time,
                order_num: wait.order_num,
                customer_id: wait.customer_id,
                resource_id: wait.resource_id,
                service_id: wait.service_id,
                booking_id: wait.booking_id,
                name: wait.customers[0].name,
                resource: wait.resource,
                customer_group_id: wait.customers[0].customer_group_id,
                email: wait.customers[0].email,
                phone: wait.customers[0].phone,
                description: wait.customers[0].description,
                meta: wait.customers[0].customer_meta.map((meta_data) => {
                  if (meta_data['client_fields'][0] != undefined) {
                    return Object.assign(
                      {},
                      {
                        meta_key: meta_data.meta_key,
                        meta_value: meta_data.meta_value,

                        type: meta_data['client_fields'][0]['type'],
                      },
                    );
                  }
                }),
              },
            );
          }
        });
      });

    Data = Data.filter((item) => item != null);
    return Data;
  }
}
module.exports = new CustomersService();
