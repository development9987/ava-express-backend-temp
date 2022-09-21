'use strict';

module.exports = (sequelize, DataTypes) => {
  const description_resources = sequelize.define(
    `description_resources`,
    {
      description_id: DataTypes.INTEGER,
      resource_id: DataTypes.STRING,
    },
    { timestamps: false }
  );
  description_resources.associate = function (models) {};
  return description_resources;
};
