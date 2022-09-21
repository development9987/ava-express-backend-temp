'use strict';
module.exports = (sequelize, DataTypes) => {
  const resources = sequelize.define(
    'resources',
    {
      ID: {
        type: DataTypes.STRING,
        primaryKey: true,
      },
      user_id: DataTypes.INTEGER,
      manager_id: DataTypes.INTEGER,
      name: DataTypes.STRING,
      display_name: DataTypes.STRING,
      category_name: DataTypes.STRING,
      email: DataTypes.STRING,
      phone: DataTypes.STRING,
      img_path: DataTypes.STRING,
      description: DataTypes.TEXT,
      created_at: DataTypes.DATE,
      updated_at: DataTypes.DATE,
      is_sign_up: DataTypes.STRING,
      working_hour: DataTypes.STRING,
      working_data: DataTypes.STRING,
      serviceProvide: DataTypes.STRING,
      available: DataTypes.STRING,
    },
    {
      timestamps: false,
    },
  );

  resources.associate = function (models) {
    resources.belongsTo(models.waitlists, {
      foreignKey: 'id',
      targetKey: 'resource_id',
    });
    resources.belongsTo(models.bookings, {
      foreignKey: 'id',
      targetKey: 'resource',
    });
    resources.hasOne(models.users, {
      foreignKey: 'id',
      sourceKey: 'manager_id',
    });
  };
  return resources;
};
