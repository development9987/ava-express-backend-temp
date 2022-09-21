const twilioConfig = require('../../config/twilio.config');
const client = require('twilio')(twilioConfig.sid, twilioConfig.token);

class TwilioService {
  async sendSMS(received_number, message) {
    try {
      let data = {
        from: twilioConfig.phone_number,
        to: received_number,
        body: message,
      };

      await client.messages.create(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
module.exports = new TwilioService();
