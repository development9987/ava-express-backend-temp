const db = require('../db/models');
const waitlists = db.waitlists;
const customers = db.customers;
const bookings = db.bookings;
const customer_meta = db.customer_meta;
const sale_datas = db.sale_datas;
const sales = db.sales;
const settingsService = require('../services/settings/settings.service');
const moment = require('moment');
const { getResultQuery } = require('../core/util');

module.exports = {
  async getReports(req, res) {
    try {
      const admin_id = await settingsService.getAdminId(req.params.user_id);
      var customerDatas;
      if (req.params.type == 'Served') {
        customerDatas = await getResultQuery(
          `SELECT t0.*,IF(t1.wait_time IS NULL,'',t1.wait_time) AS wait_time, IF(t1.wait_time IS NULL,0,t1.serve_time-t1.wait_time ) AS waited_time, t1.done_time-t1.serve_time AS served_time FROM customers AS t0 INNER JOIN waitlists AS t1 ON t1.customer_id = t0.id WHERE t0.user_id = ${admin_id} AND t1.serve_time IS NOT NULL`,
        );
      } else if (req.params.type == 'Waitlist') {
        customerDatas = await getResultQuery(
          `SELECT t0.*,t1.wait_time, t1.done_time-serve_time AS served_time IF(t1.wait_time IS NULL,'0',t1.serve_time-t1.wait_time ) AS waited_time FROM customers AS t0 INNER JOIN waitlists AS t1 ON t1.customer_id = t0.id WHERE t0.user_id = ${admin_id} AND t1.serve_time IS NULL AND t1.done_time IS NULL`,
        );
      } else if (req.params.type == 'Booking') {
        customerDatas = await getResultQuery(
          `SELECT t0.*, t1.startDate,t1.endDate, t1.done_time-t2.serve_time AS served_time  t1.serve_time-t1.wait_time AS waited_time FROM customers AS t0 INNER JOIN bookings AS t1 ON t1.customer_id = t0.id WHERE t0.user_id =  ${admin_id}`,
        );
      }
      await Promise.all(
        customerDatas.map(async (data) => {
          let meta_datas = await customer_meta.findAll({
            where: {
              customerId: data.id,
            },
          });
          meta_datas.forEach((element) => {
            data[element.meta_key] = element.meta_value;
          });
        }),
      );
      res.status(200).send({
        success: true,
        result: customerDatas,
        message: 'here',
      });
    } catch (e) {
      console.log(e);
      res.status(400).send({ success: false });
    }
  },
  async getSalesData(req, res) {
    try {
      let tmpId = await settingsService.getAdminId(req.user.id);
      let result = await customers.findAll({
        include: [{ model: sale_datas, include: [{ model: sales, order: [['sale_id', 'ASC']] }] }],
        where: {
          user_id: tmpId,
        },
      });
      res.status(200).send({
        success: true,
        result: result,
      });
    } catch (e) {
      console.log(e);
      res.status(400).send({ success: false });
    }
  },
};
