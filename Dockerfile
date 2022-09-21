FROM node:12-alpine
WORKDIR /webapps/insight2
COPY . ./
RUN npm install -g pm2
RUN npm install -g sequelize-cli
RUN npm install -g mysql2
RUN npm install
RUN chmod +x ./run.sh
EXPOSE 8000
CMD ["./run.sh"]
