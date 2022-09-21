'use strict';
module.exports = (sequelize, DataTypes) => {
  const customers = sequelize.define(
    'customers',
    {
      user_id: DataTypes.INTEGER,
      name: DataTypes.STRING,
      customer_group_id: DataTypes.STRING,
      email: DataTypes.STRING,
      phone: DataTypes.STRING,
      description: DataTypes.TEXT,
      created_at: DataTypes.DATE,
      updated_at: DataTypes.DATE,
    },
    {
      timestamps: false,
    },
    {
      indexes: [
        {
          unique: false,
          fields: ['email'],
        },
      ],
    },
  );
  customers.associate = function (models) {
    customers.hasMany(models.sale_datas, {
      foreignKey: 'customer_id',
      sourceKey: 'id',
    });
    customers.belongsTo(models.waitlists, {
      foreignKey: 'id',
      targetKey: 'customer_id',
    });
    customers.hasMany(models.customer_meta);

    customers.belongsTo(models.bookings, {
      foreignKey: 'id',
      targetKey: 'customer_id',
    });
    customers.hasMany(models.customer_meta);
  };
  return customers;
};
