'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('users', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },
      businessID: {
        type: Sequelize.STRING(20),
      },
      username: {
        type: Sequelize.STRING(50),
      },
      firstname: {
        type: Sequelize.STRING(50),
      },
      lastname: {
        type: Sequelize.STRING(50),
      },
      email: {
        type: Sequelize.STRING(50),
      },
      password: {
        type: Sequelize.STRING(100),
      },
      email_verified_at: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      avatarUrl: {
        type: Sequelize.TEXT,
      },
      role: {
        type: Sequelize.STRING(15),
      },
      remember_token: {
        type: Sequelize.STRING,
      },
      last_login: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      created_at: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      updated_at: {
        allowNull: false,
        type: Sequelize.DATE,
      },
    });
  },
  down: (queryInterface) => {
    return queryInterface.dropTable('users');
  },
};
