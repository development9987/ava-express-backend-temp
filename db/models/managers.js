'use strict';
module.exports = (sequelize, DataTypes) => {
  const managers = sequelize.define(
    'managers',
    {
      ID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
      },
      user_id: DataTypes.INTEGER,
      name: DataTypes.STRING,
      email: DataTypes.STRING,
      is_sign_up: DataTypes.STRING,
    },
    { timestamps: false }
  );
  return managers;
};
