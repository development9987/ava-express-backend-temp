'use strict';
module.exports = (sequelize, DataTypes) => {
  const tasks = sequelize.define(
    'tasks',
    {
      user_id: DataTypes.INTEGER,
      title: DataTypes.STRING,
      task_period: DataTypes.STRING,
      created_at: DataTypes.DATE,
      updated_at: DataTypes.DATE,
      progress: DataTypes.STRING,
    },
    { timestamps: false }
  );
  tasks.associate = function (models) {};
  return tasks;
};
