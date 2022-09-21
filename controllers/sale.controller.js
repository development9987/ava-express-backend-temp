const moment = require('moment');
const db = require('../db/models');

const { sales } = db;
const sales_sequences = db.sales_sequence;
const { sale_datas } = db;
const settingsService = require('../services/settings/settings.service');

module.exports = {
  async add(req, res) {
    try {
      const adminId = await settingsService.getAdminId(req.user.id);
      const addedSale = await sales.create({
        user_id: adminId,
        ...req.body,
      });
      const formdata = req.body.sequence.map((e) => {
        return { ...e, sale_id: addedSale.id };
      });
      await sales_sequences.bulkCreate(formdata);
      const result = await sales.findOne({
        include: [
          { model: sales_sequences, required: false },
          { model: sale_datas, required: false },
        ],
        where: {
          id: addedSale.id,
        },
      });
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
      res.status(400).send({
        message: e,
      });
    }
  },
  async get(req, res) {
    try {
      const adminId = await settingsService.getAdminId(req.user.id);
      const result = await sales.findAll({
        include: [
          { model: sales_sequences, required: false },
          { model: sale_datas, required: false },
        ],
        where: {
          user_id: adminId,
        },
      });
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
      res.status(400).send({
        message: e,
      });
    }
  },
  async getByCustomer(req, res) {
    try {
      const adminId = await settingsService.getAdminId(req.user.id);
      const result = await sale_datas.findAll({
        include: [
          {
            model: sales,
            required: true,
            include: [{ model: sales_sequences, required: false }],
          },
        ],
        where: {
          user_id: adminId,
          customer_id: req.params.id,
        },
      });
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
      res.status(400).send({
        message: e,
      });
    }
  },
  async update(req, res) {
    try {
      await sales.update(req.body, {
        where: {
          id: req.body.id,
        },
      });
      if (req.body.sequence) {
        const formdata = req.body.sequence.map((e) => {
          return { ...e, sale_id: req.body.id };
        });
        await sales_sequences.destroy({
          where: {
            sale_id: req.body.id,
          },
        });
        await sales_sequences.bulkCreate(formdata);
      }
      const result = await sales.findOne({
        include: [
          { model: sales_sequences, required: false },
          { model: sale_datas, required: false },
        ],
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
      res.status(400).send({
        message: e,
      });
    }
  },
  async delete(req, res) {
    try {
      await sales.destroy({
        where: {
          id: req.params.id,
        },
      });
      await sales_sequences.destroy({
        where: {
          sale_id: req.params.id,
        },
      });
      res.status(200).send({
        success: true,
      });
    } catch (e) {
      console.log(e);
      res.status(400).send({
        message: e,
      });
    }
  },
  async addSaleData(req, res) {
    try {
      const adminId = await settingsService.getAdminId(req.user.id);
      let dateTime = new Date();
      dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
      const formdata = [];
      req.body.map((e) => {
        formdata.push({
          ...e,
          created_at: dateTime,
          user_id: adminId,
        });
        return null;
      });
      const result = [];
      await sale_datas.bulkCreate(formdata).then(async (obj) => {
        await Promise.all(
          obj.map(async (e) => {
            await sale_datas
              .findOne({
                where: {
                  id: e.id,
                },
                include: [
                  {
                    model: sales,
                    required: true,
                    include: [{ model: sales_sequences, required: false }],
                  },
                ],
              })
              .then((sale) => {
                result.push(sale);
              });
          }),
        );
      });

      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      res.status(400).send({
        message: e,
      });
    }
  },
};
