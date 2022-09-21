'use strict';
module.exports = (sequelize, DataTypes) => {
  const message_histories = sequelize.define(
    'message_histories',
    {
      customer_id: DataTypes.INTEGER,
      business_id: DataTypes.STRING,
      subject: DataTypes.TEXT,
      message: DataTypes.TEXT,
      send_at: DataTypes.DATE,
      is_success: DataTypes.BOOLEAN,
      sending_type: DataTypes.STRING,
      message_type: DataTypes.STRING,
    },
    { timestamps: false }
  );
  return message_histories;
};
