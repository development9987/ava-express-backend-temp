'use strict';
module.exports = (sequelize, DataTypes) => {
  const message_templates = sequelize.define(
    'message_templates',
    {
      name: DataTypes.STRING,
      user_id: DataTypes.INTEGER,
      send_as_sms: DataTypes.BOOLEAN,
      sms_template: DataTypes.TEXT,
      left_charactor: DataTypes.INTEGER,
      send_as_email: DataTypes.BOOLEAN,
      email_subject: DataTypes.TEXT,
      email_template: DataTypes.TEXT,
      enable: DataTypes.BOOLEAN,
    },
    { timestamps: false },
  );
  return message_templates;
};
