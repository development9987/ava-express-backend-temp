const getResultQuery = require('../../core/util').getResultQuery;

class ChatService {
  async getChatUsers(authId) {
    // console.log(authId)
    try {
      // let query = `SELECT t0.*,t1.*, t2.message AS lastMessage, t2.created_at AS lastMessageTime FROM users AS t0 LEFT JOIN (SELECT t0.sender_id, t0.receiver_id, SUM(IF(is_read = 0,1,0)) AS unreadMessage, t0.created_at FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY sender_id, receiver_id ORDER BY id DESC) AS row_num FROM messages) AS t0 WHERE receiver_id = ${authId} OR sender_id = ${authId} GROUP BY sender_id, receiver_id) AS t1 ON t0.id = t1.sender_id LEFT JOIN (SELECT * FROM messages WHERE id IN (SELECT MAX(id) FROM messages WHERE sender_id = ${authId} OR receiver_id = ${authId})) AS t2 ON t0.id = t2.sender_id OR t0.id = t2.receiver_id WHERE t0.businessID IN (SELECT businessID FROM users WHERE id=${authId}) AND t0.id != ${authId}`;
      let query='SELECT customers.* FROM customers LEFT JOIN users ON customers.user_id=users.id where users.id = '+authId;
      let res = await getResultQuery(query);
      // console.log(res)

      return res;
    } catch (e) {
      console.log(e);
    }
    

  }

  successResponse(data) {
    return {
      ok: true,
      data: data,
    };
  }

  errorResponse(error) {
    return {
      ok: false,
      data: error,
    };
  }
}
module.exports = new ChatService();
