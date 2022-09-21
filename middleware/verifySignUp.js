const db = require('../db/models');
const users = db.users;


const checkDuplicateEmail = (req, res, next) => {
  users
    .findOne({
      where: {
        email: req.body.email,
      },
    })
    .then((user) => {
      if (user) {
        return res.status(200).send({
          success: false,
          result: {
            tag: 'email',
            message: 'This email is already used',
          },
        });
      }
      next();
    });
};

const verifySignUp = {
  checkDuplicateEmail: checkDuplicateEmail,
};

module.exports = verifySignUp;
