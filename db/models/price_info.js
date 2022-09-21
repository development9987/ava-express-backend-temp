'use strict';
module.exports = (sequelize, DataTypes) => {
  const price_info = sequelize.define(
    'price_info',
    {
      title: DataTypes.STRING,
      priceID: DataTypes.STRING,
      type: DataTypes.STRING,
      limitedNums: DataTypes.INTEGER,
    },
    { timestamps: false },
  );

  price_info.associate = function (models) {
    price_info.belongsTo(models.business_membership, {
      foreignKey: 'priceID',
      targetKey: 'priceID',
    });
  };
  return price_info;
};
