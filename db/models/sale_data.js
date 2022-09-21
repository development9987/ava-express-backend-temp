'use strict';
module.exports = (sequelize, Datatypes) => {
  const sale_datas = sequelize.define(
    'sale_datas',
    {
      id: {
        type: Datatypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      sale_id: Datatypes.INTEGER,
      user_id: Datatypes.INTEGER,
      customer_id: Datatypes.INTEGER,
      resource_id: Datatypes.STRING,
      state: Datatypes.STRING,
      sale_num: Datatypes.INTEGER,
      created_at: Datatypes.DATE,
    },
    {
      timestamps: false,
    },
  );
  sale_datas.associate = function (models) {
    sale_datas.belongsTo(models.sales, {
      foreignKey: 'sale_id',
      targetKey: 'id',
    });
    sale_datas.hasOne(models.sales, {
      foreignKey: 'id',
      sourceKey: 'sale_id',
    });
    sale_datas.belongsTo(models.customers, {
      foreignKey: 'customer_id',
      targetKey: 'id',
    });
  };
  return sale_datas;
};
