const { business_info, users, customers } = require('../db/models');

module.exports = {
  async getAgencyData(req, res) {
    try {
      const result = await business_info.findAll({
        include: [
          {
            model: users,
            required: true,
            where: {
              role: 'admin',
            },
            attributes: [],
          },
        ],
      });

      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      res.status(400).send(e);
    }
  },
  async changeState(req, res) {
    try {
      await business_info.update(
        {
          business_state: req.body.business_state,
        },
        {
          where: {
            ID: req.body.ID,
          },
        },
      );
      const result = await business_info.findOne({
        include: [
          {
            model: users,
            required: true,
            where: {
              role: 'admin',
            },
            attributes: [],
          },
        ],
        where: {
          ID: req.body.ID,
        },
      });
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      res.status(400).send(e);
    }
  },
  async getAgencyInfo(req, res) {
    try {
      const admin = await users.findOne({
        where: { businessID: req.params.ID, role: 'admin' },
      });
      const userData = await users.findAll({
        where: {
          businessID: req.params.ID,
        },
      });
      const customerData = await customers.findAll({
        where: {
          user_id: admin.id,
        },
        raw: true,
      });
      res.status(200).send({
        success: true,
        result: {
          userData,
          customerData,
        },
      });
    } catch (e) {
      res.status(400).send(e);
    }
  },
};
