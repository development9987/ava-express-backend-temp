'use strict';
module.exports = (sequelize, DataTypes) => {
  const user_meta = sequelize.define(
    'user_meta',
    {
      userId: DataTypes.INTEGER,
      meta_key: DataTypes.STRING,
      meta_value: DataTypes.STRING,
    },
    {
      timestamps: false,
    },
  );
  user_meta.associate = function (models) {
    user_meta.belongsTo(models.users);
    user_meta.hasMany(models.client_fields, {
      foreignKey: 'name',
      sourceKey: 'meta_key',
    });
  };
  return user_meta;
};
