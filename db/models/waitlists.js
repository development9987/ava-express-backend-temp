'use strict';
module.exports = (sequelize, DataTypes) => {
  const waitlists = sequelize.define(
    'waitlists',
    {
      user_id: DataTypes.INTEGER,
      customer_id: DataTypes.INTEGER,
      wait_time: DataTypes.DATE,
      serve_time: DataTypes.DATE,
      // done_time: DataTypes.DATE,
      is_show: DataTypes.INTEGER,
      order_num: DataTypes.INTEGER,
      resource_id: DataTypes.INTEGER,
      priority:DataTypes.INTEGER
      // booking_id: DataTypes.BOOLEAN,
      // service_id: DataTypes.STRING,
    },
    { timestamps: false },
  );
  waitlists.associate = function (models) {
    waitlists.hasMany(models.customers, {
      foreignKey: 'id',
      sourceKey: 'customer_id',
    });
    waitlists.hasOne(models.resources, {
      foreignKey: 'id',
      sourceKey: 'resource_id',
    });
  };
  return waitlists;
};
