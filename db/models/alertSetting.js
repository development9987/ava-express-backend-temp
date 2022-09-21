'use strict';
module.exports = (sequelize, DataTypes) => {
  const alerts = sequelize.define(
    'alert_setting',
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
      },
      user_id: DataTypes.INTEGER,
      key: DataTypes.STRING,
      data_field: DataTypes.STRING,
      enable: DataTypes.BOOLEAN,
    },
    { timestamps: false }
  );
  return alerts;
};
