'use strict';
module.exports = (sequelize, DataTypes) => {
  const users = sequelize.define(
    'users',
    {
      phone: DataTypes.STRING,
      description: DataTypes.TEXT,
      businessID: DataTypes.STRING,
      firstname: DataTypes.STRING,
      lastname: DataTypes.STRING,
      username: DataTypes.STRING,
      email: DataTypes.STRING,
      email_verified_at: DataTypes.STRING,
      password: DataTypes.STRING,
      avatarUrl: DataTypes.STRING,
      role: DataTypes.STRING,
      remember_token: DataTypes.STRING,
      last_login: DataTypes.STRING,
      created_at: DataTypes.DATE,
      updated_at: DataTypes.DATE,
    },
    { timestamps: false },
  );

  users.associate = function (models) {
    users.belongsTo(models.resources, {
      foreignKey: 'id',
      targetKey: 'manager_id',
    });
    users.belongsTo(models.business_info, {
      foreignKey: 'id',
      targetKey: 'user_id',
    });
  };

  return users;
};
