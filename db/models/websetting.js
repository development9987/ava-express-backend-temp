'use strict';
module.exports = (sequelize, DataTypes) => {
  const website_settings = sequelize.define(
    'website_settings',
    {
      ID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
      },
    name: DataTypes.STRING,
    email:DataTypes.STRING,
    address:DataTypes.STRING,
    logo:DataTypes.STRING  
    },
    { timestamps: false }
  );
  return website_settings;
};
