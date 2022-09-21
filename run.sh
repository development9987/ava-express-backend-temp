#!/bin/sh
npm run db:migrate
npx sequelize-cli db:seed:all
npm start
