'use strict';
module.exports = (sequelize, Datatypes) => {
  const sales = sequelize.define(
    'sales',
    {
      id: {
        type: Datatypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      user_id: Datatypes.INTEGER,
      name: Datatypes.STRING,
      category: Datatypes.STRING,
      targetNum: Datatypes.INTEGER,
      description: Datatypes.TEXT,
    },
    {
      timestamps: false,
    },
  );
  sales.associate = function (models) {
    sales.hasMany(models.sales_sequence, {
      foreignKey: 'sale_id',
      sourceKey: 'id',
    });
    sales.hasMany(models.sale_datas, {
      foreignKey: 'sale_id',
      sourceKey: 'id',
    });
    sales.belongsTo(models.sale_datas, {
      foreignKey: 'id',
      targetKey: 'sale_id',
    });
  };
  return sales;
};
