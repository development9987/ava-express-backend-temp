const db = require('../../db/models');
const users = db.users;
const resources = db.resources;
const customers = db.customers;
const customer_meta = db.customer_meta;
const clientFields = db.client_fields;
const bookings = db.bookings;
const getResultQuery = require('../../core/util').getResultQuery;

const settingsService = require('../../services/settings/settings.service');
const BaseService = require('../base.service');
class BookingService extends BaseService {
  async getBookingDataByUser(user_id) {
    var Data = [];
    let admin_id = await settingsService.getAdminId(user_id);
    let user = await users.findOne({
      where: {
        id: user_id,
      },
    });

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
        where: {
          manager_id: user_id,
        },
        required: true,
      });
    }
    var whereCondition = { user_id: admin_id };
    if (user.role === 'resource') {
      var resource = await resources.findOne({
        where: {
          name: user.username,
          email: user.email,
        },
      });
      if (resource) {
        whereCondition.resource = resource.ID;
      }
    }
    await bookings
      .findAll({
        include: include,
        where: whereCondition,
      })
      .then((books) => {
        Data = books.map((book) => {
          if (book.customers[0] != null) {
            return Object.assign(
              {},
              {
                id: book.id,
                user_id: book.user_id,
                customer_id: book.customer_id,
                title: book.title,
                resource: book.resource,
                service_id: book.service_id,
                note: book.note,
                startDate: book.startDate,
                endDate: book.endDate,
                appointment_key: book.appointment_key,
                appointment_type: book.appointment_type,
                appointment_time: book.appointment_time,
                serve_time: book.serve_time,
                done_time: book.done_time,
                name: book.customers[0].name,
                customer_group_id: book.customers[0].customer_group_id,
                email: book.customers[0].email,
                phone: book.customers[0].phone,
                description: book.customers[0].description,
                meta: book.customers[0].customer_meta.map((meta_data) => {
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

  async getBookingDataById(id) {
    try {
      let data = await getResultQuery(`SELECT * FROM bookings WHERE id = ${id}`);
      return data;
    } catch (e) {
      return false;
    }
  }

  async validationAppointmentKey(key) {
    try {
      let data = await getResultQuery(
        `SELECT t0.*, t1.firstname FROM bookings AS t0 JOIN users AS t1 ON t0.user_id = t1.id WHERE appointment_key = "${key}"`,
      );
      return data;
    } catch (e) {
      return false;
    }
  }

  async getRemaingDuration(string) {
    switch (string) {
      case '5 min': {
        return [5, 'minutes'];
      }
      case '10 min': {
        return [10, 'minutes'];
      }
      case '15 min': {
        return [15, 'minutes'];
      }
      case '30 min': {
        return [30, 'minutes'];
      }
      case '1 hour': {
        return [1, 'hours'];
      }
      case '2 hour': {
        return [2, 'hours'];
      }
      case '3 hour': {
        return [3, 'hours'];
      }
      case '12 hour': {
        return [12, 'hours'];
      }
      case '1 day': {
        return [1, 'days'];
      }
      case '2 day': {
        return [2, 'days'];
      }
      case '3 day': {
        return [3, 'days'];
      }
      case '4 day': {
        return [4, 'days'];
      }
      case '5 day': {
        return [5, 'days'];
      }
      case '1 week': {
        return [1, 'weeks'];
      }
      case '2 weeks': {
        return [2, 'weeks'];
      }
      case '3 weeks': {
        return [3, 'weeks'];
      }
      case '1 month': {
        return [1, 'months'];
      }
    }
  }
}
module.exports = new BookingService();
