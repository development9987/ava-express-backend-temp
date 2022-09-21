const nodemailer = require('nodemailer');
const sgTransport = require('nodemailer-sendgrid-transport');
const Email = require('email-templates');

const emailConfig = require('../../config/email.config');

class EmailService {
  constructor() {
    this.email = this.getMailTransporter();
  }

  getMailTransporter() {
    const options = {
      service: 'SendGrid',
      auth: {
        user: emailConfig.username,
        pass: emailConfig.password,
        api_key: emailConfig.apikey,
      },
    };
    const transporter = nodemailer.createTransport(sgTransport(options));

    const email = new Email({
      transport: transporter,
      send: true,
      preview: false,
    });

    return email;
  }

  async sendEmail(data) {
    try {
      await this.email.send(data);
      return true;
    } catch (e) {
      console.log(e);
      return false;
    }
  }
}
module.exports = new EmailService();
