'use strict';
module.exports = (sequelize, DataTypes) => {
  const customer_meta = sequelize.define(
    'customer_meta',
    {
      customerId: DataTypes.INTEGER,
      meta_key: DataTypes.STRING,
      meta_value: DataTypes.STRING,
    },
    {
      timestamps: false,
    },
  );
  customer_meta.associate = function (models) {
    customer_meta.belongsTo(models.customers);
    customer_meta.hasMany(models.client_fields, {
      foreignKey: 'name',
      sourceKey: 'meta_key',
    });
  };
  return customer_meta;
};
