'use strict';
module.exports = (sequelize, DataTypes) => {
  const services = sequelize.define(
    'services',
    {
      user_id: DataTypes.BIGINT,
      name: DataTypes.STRING,
      display_name: DataTypes.STRING,
      category_name: DataTypes.STRING,
      color: DataTypes.STRING,
      email:DataTypes.STRING,
      phone:DataTypes.STRING,
      img_path: DataTypes.STRING,
      description: DataTypes.TEXT,
      created_at: DataTypes.DATE,
      updated_at: DataTypes.DATE,
    },
    {
      timestamps: false,
    }
  );

  services.associate = function (models) {};
  return services;
};
