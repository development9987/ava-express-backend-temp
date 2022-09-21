'use strict';
module.exports = (sequelize, DataTypes) => {
  const bookings = sequelize.define(
    'bookings',
    {
      user_id: DataTypes.INTEGER,
      customer_id: DataTypes.INTEGER,
      title: DataTypes.STRING,
      note: DataTypes.TEXT,
      resource: DataTypes.STRING,
      startDate: DataTypes.DATE,
      endDate: DataTypes.DATE,
      appointment_type: DataTypes.INTEGER,
      appointment_time: DataTypes.DATE,
      appointment_key: DataTypes.STRING,
      serve_time: DataTypes.DATE,
      done_time: DataTypes.DATE,
      is_remind: DataTypes.BOOLEAN,
      service_id: DataTypes.STRING,
    },
    { timestamps: false },
  );
  bookings.associate = function (models) {
    bookings.hasMany(models.customers, {
      foreignKey: 'id',
      sourceKey: 'customer_id',
    });
    bookings.hasMany(models.resources, {
      foreignKey: 'id',
      sourceKey: 'resource',
    });
  };
  return bookings;
};
