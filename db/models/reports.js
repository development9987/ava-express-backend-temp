'use strict';
module.exports = (sequelize, DataTypes) => {
  const reports = sequelize.define(
    'reports',
    {
      description_id: DataTypes.INTEGER,
      resource_id: DataTypes.STRING,
      report: DataTypes.TEXT,
      created_at: DataTypes.DATE,
      updated_at: DataTypes.DATE,
    },
    { timestamps: false }
  );
  reports.associate = function (models) {};
  return reports;
};
