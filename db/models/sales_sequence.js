'use strict';
module.exports = (sequelize, DataTypes) => {
  const sales_sequence = sequelize.define(
    'sales_sequence',
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
      },
      sale_id: DataTypes.INTEGER,
      type: DataTypes.STRING,
      behavior: DataTypes.STRING,
    },
    { timestamps: false },
  );
  sales_sequence.associate = function (models) {
    sales_sequence.belongsTo(models.sales, {
      foreignKey: 'sale_id',
      targetKey: 'id',
    });
  };
  return sales_sequence;
};
