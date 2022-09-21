'use strict';
module.exports = (sequelize, DataTypes) => {
  const business_membership = sequelize.define(
    'business_membership',
    {
      businessID: DataTypes.STRING,
      priceID: DataTypes.STRING,
      startDate: DataTypes.DATEONLY,
      endDate: DataTypes.DATEONLY,
      state: DataTypes.STRING,
    },
    { timestamps: false },
  );

  business_membership.associate = function (models) {
    business_membership.belongsTo(models.business_info, {
      foreignKey: 'businessID',
      targetKey: 'ID'
    })
    business_membership.hasOne(models.price_info, {
      foreignKey: 'priceID',
      sourceKey: 'priceID',
    });
  };
  return business_membership;
};
