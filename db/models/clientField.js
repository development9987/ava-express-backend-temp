'use strict';
module.exports = (sequelize, DataTypes) => {
  const clientField = sequelize.define(
    'client_fields',
    {
      ID: {
        type: DataTypes.STRING,
      },
      enable: DataTypes.STRING,
      name: DataTypes.STRING,
      label: DataTypes.STRING,
      type: DataTypes.STRING,
      placeholder: DataTypes.STRING,
      options: DataTypes.STRING,
      defaultValue: DataTypes.STRING,
      ordering: DataTypes.STRING,
      PORV: DataTypes.STRING,
      for: DataTypes.STRING,
      is_required: DataTypes.STRING,
      is_multiple: DataTypes.STRING,
      is_add_option: DataTypes.STRING,
      is_pre_select: DataTypes.STRING,
      user_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
      },
    },
    { timestamps: false },
  );
  clientField.associate = function (models) {
    clientField.belongsTo(models.customer_meta, {
      foreignKey: 'name',
      targetKey: 'meta_key',
    });
  };
  return clientField;
};
