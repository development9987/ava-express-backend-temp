'use strict';
module.exports = (sequelize, DataTypes) => {
  const staff = sequelize.define(
    'staffs',
    {
      user_id: DataTypes.INTEGER,
      name: DataTypes.STRING,
      // customer_group_id: DataTypes.STRING,
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
  staff.associate = function (models) {
    // staff.hasMany(models.sale_datas, {
    //   foreignKey: 'customer_id',
    //   sourceKey: 'id',
    // });
    // staff.belongsTo(models.waitlists, {
    //   foreignKey: 'id',
    //   targetKey: 'customer_id',
    // });
    staff.hasMany(models.staff_meta);

    // staff.belongsTo(models.bookings, {
    //   foreignKey: 'id',
    //   targetKey: 'customer_id',
    // });
    staff.hasMany(models.staff_meta);
  };
  return staff;
};
