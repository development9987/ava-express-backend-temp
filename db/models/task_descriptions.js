'use strict';
module.exports = (sequelize, DataTypes) => {
  const task_descriptions = sequelize.define(
    'task_descriptions',
    {
      task_id: DataTypes.INTEGER,
      title: DataTypes.STRING,
      // resources: DataTypes.STRING,
      created_at: DataTypes.DATE,
      updated_at: DataTypes.DATE,
      is_done: DataTypes.BOOLEAN,
    },
    { timestamps: false }
  );
  task_descriptions.associate = function (models) {};
  return task_descriptions;
};
