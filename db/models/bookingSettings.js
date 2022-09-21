'use strict';
module.exports = (sequelize, DataTypes) => {
  const waitlistSetting = sequelize.define(
    'booking_setting',
    {
      ID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
      },
      user_id: DataTypes.INTEGER,
      minDuration: DataTypes.STRING,
      maxDuration: DataTypes.STRING,
      SpotsPerTimeSlot: DataTypes.INTEGER,
      DefaultView: DataTypes.STRING,
      EndHour: DataTypes.STRING,
      StartHour: DataTypes.STRING,
      WeekStartDay: DataTypes.STRING,
      HidePast: DataTypes.BOOLEAN,
      AllowCustomerCancelBooking: DataTypes.BOOLEAN,
      AllowCustomerRescheduleBooking: DataTypes.BOOLEAN,
      AllowStaffOverBookFullTimeSlot: DataTypes.BOOLEAN,
      MaxAdvanceKind: DataTypes.STRING,
      MaxAdvanceNumber: DataTypes.INTEGER,
      MaxBooking: DataTypes.STRING,
      MinBooking: DataTypes.STRING,
      MinNoticeKind: DataTypes.STRING,
      MinNoticeNumber: DataTypes.INTEGER,
      RejectDuplicate: DataTypes.BOOLEAN,
      RejectFlagged: DataTypes.BOOLEAN,
      openingGeneralHours: DataTypes.STRING,
      openingWaitListHours: DataTypes.STRING,
      openingBookingHours: DataTypes.STRING,
      CalendarData: DataTypes.STRING,
      PublicBookingUrl: DataTypes.STRING,
    },
    { timestamps: false }
  );
  return waitlistSetting;
};
