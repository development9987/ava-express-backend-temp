'use strict';
module.exports = (sequelize, DataTypes) => {
  const packages = sequelize.define(
    'packages',
    {
      name: DataTypes.STRING,
      description: DataTypes.TEXT,
      price: DataTypes.STRING,
      created_at: DataTypes.DATE,
      updated_at: DataTypes.DATE,
    },
    { timestamps: false },
  );

  // users.associate = function (models) {
  //   users.belongsTo(models.resources, {
  //     foreignKey: 'id',
  //     targetKey: 'manager_id',
  //   });
  //   users.belongsTo(models.business_info, {
  //     foreignKey: 'id',
  //     targetKey: 'user_id',
  //   });
  // };

  return packages;
};
