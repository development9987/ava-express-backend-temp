'use strict';
module.exports = (sequelize, DataTypes) => {
  const messages = sequelize.define(
    'messages',
    {
      sender_id: DataTypes.INTEGER,
      receiver_id: DataTypes.INTEGER,
      message: DataTypes.STRING,
      msg_type: DataTypes.STRING,
      is_read: DataTypes.INTEGER,
      created_at: DataTypes.DATE,
      updated_at: DataTypes.DATE,
      deleted_at: DataTypes.DATE,
    },
    { timestamps: false }
  );
  return messages;
};
