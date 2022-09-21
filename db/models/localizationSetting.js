'use strict';
module.exports = (sequelize, DataTypes) => {
  const localization = sequelize.define(
    'localization',
    {
      ID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
      },
      user_id: DataTypes.INTEGER,
      timezone: DataTypes.STRING,
    },
    { timestamps: false }
  );
  return localization;
};
