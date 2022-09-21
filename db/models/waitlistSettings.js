'use strict';
module.exports = (sequelize, DataTypes) => {
  const waitlistSetting = sequelize.define(
    'waitlist_setting',
    {
      ID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
      },
      user_id: DataTypes.INTEGER,
      location_name: DataTypes.STRING,
      limit_max_waiting: DataTypes.BOOLEAN,
      limit_max_wait_number: DataTypes.STRING,
      reject_duplicates: DataTypes.BOOLEAN,
      reject_flagged: DataTypes.BOOLEAN,
      waiting: DataTypes.STRING,
      serving: DataTypes.STRING,
      default_serve_duration: DataTypes.INTEGER,
      default_serve_duration_type: DataTypes.STRING,
      number_of_serve_people: DataTypes.INTEGER,
      service_duration: DataTypes.BOOLEAN,
      status_indicator: DataTypes.STRING,
      hide_cancel: DataTypes.BOOLEAN,
      call_business: DataTypes.BOOLEAN,
      PublicWaitlistUrl: DataTypes.STRING,
    },
    { timestamps: false }
  );
  return waitlistSetting;
};
