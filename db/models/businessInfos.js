'use strict';
module.exports = (sequelize, DataTypes) => {
  const businessInfos = sequelize.define(
    'business_info',
    {
      ID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
      },
      user_id: DataTypes.INTEGER,
      business_name: DataTypes.STRING,
      business_logo: DataTypes.STRING,
      // business_color: DataTypes.STRING,
      // business_state: DataTypes.BOOLEAN,
      // sale_state: DataTypes.STRING,
      // customer_id: DataTypes.STRING,
      // watilist_add_time: DataTypes.INTEGER,
      // booking_add_time: DataTypes.INTEGER,
      // served_add_time: DataTypes.INTEGER,
      // manager_add_time: DataTypes.INTEGER,
      // resource_add_time: DataTypes.INTEGER,
      // customer_add_time: DataTypes.INTEGER,
      // service_add_time: DataTypes.INTEGER,
      // total_add_time: DataTypes.INTEGER,
    },
    { timestamps: false },
  );

  businessInfos.associate = function (models) {
    businessInfos.hasOne(models.users, {
      foreignKey: 'id',
      sourceKey: 'user_id',
    });
    businessInfos.hasOne(models.business_membership, {
      foreignKey: 'businessID',
      sourceKey: 'ID',
    });
  };
  return businessInfos;
};
