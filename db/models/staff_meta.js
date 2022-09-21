'use strict';
module.exports = (sequelize, DataTypes) => {
  const staff_meta = sequelize.define(
    'staff_meta',
    {
      staffId: DataTypes.INTEGER,
      meta_key: DataTypes.STRING,
      meta_value: DataTypes.STRING,
    },
    {
      timestamps: false,
    },
  );
  staff_meta.associate = function (models) {
    staff_meta.belongsTo(models.staffs);
    staff_meta.hasMany(models.client_fields, {
      foreignKey: 'name',
      sourceKey: 'meta_key',
    });
  };
  return staff_meta;
};
