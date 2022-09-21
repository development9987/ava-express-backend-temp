const db = require('../db/models');
const sequelize = require('../db/models').Sequelize;
const Op = sequelize.Op;
const users = db.users;
const messages = db.messages;

const moment = require('moment');
const chatService = require('../services/chat/chat.service');
// console.log("----------------------$-------"+db+"-----------------------------")

module.exports = {
  async getUsers(io, usersMap, req, res, next) {
    // console.log(req.params.id)

    try {
      const data = await chatService.getChatUsers(req.params.id);
      data.forEach((user) => {
        var found = Object.getOwnPropertyNames(usersMap);
        if (found.find((c) => c == user.id)) {
          user['avaliable'] = true;
        } else {
          user['avaliable'] = false;
        }
      });
      res.status(200).send({
        success: true,
        result: data,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async getConversationData(req, res) {
    // console.log(req.params.id)
    // console.log(req.params.selectedId)
    try {

      await messages.update(
        
        { is_read: 1 },
        {
          where: {
            [Op.and]: [
              
              { sender_id: req.params.id},
              { receiver_id: req.params.selectedId},
            ],
          },
        }
      );

      const data = await messages.findAll({
        where: {
          [Op.or]: [
            {
              [Op.and]: [
                { sender_id: req.params.id },
                { receiver_id: req.params.selectedId },
              ],
            },
            {
              [Op.and]: [
                { sender_id: req.params.id },
                { receiver_id: req.params.selectedId },
              ],
            },
          ],
        },
      });

      res.status(200).send({
        success: true,
        result: {
          id: req.params.selectedId,
          conversationData: data,
        },
      });
    } catch (e) {
      console.log(e);
    }
  },

  async addChatData(io, usersMap, req, res, next) {
    // console.log(req.params.id)
    // console.log(req.params.selectedId)
    console.log(req.body,"+++++++++")
    const createTime = moment().format('YYYY-MM-DD H:mm:ss');
    const newMessage = await messages.create({
      sender_id: req.body.sender_id,
      receiver_id: req.body.receiver_id,
      message: req.body.text,
      created_at: createTime,
      created_at: createTime,
      is_read: 0,
    });
    io.of('/api')
      .to(usersMap[req.body.receiver_id])
      .emit('message', newMessage);
    res.status(200).send({
      success: true,
      result: newMessage,
    });
  },
  async readMessage(io, usersMap, req, res, next) {
    await messages.update(
      { is_read: 1 },
      {
        where: {
          sender_id: req.body.sender_id,
        },
      }
    );

    const data = await chatService.getChatUsers(req.user.id);
    data.forEach((user) => {
      var found = Object.getOwnPropertyNames(usersMap);
      if (found.find((c) => c == user.id)) {
        user['avaliable'] = true;
      } else {
        user['avaliable'] = false;
      }
    });
    res.status(200).send({
      success: true,
      result: data,
    });
  },
  async updateChatData(req, res) {},

  async deleteChatData(req, res) {},
};
