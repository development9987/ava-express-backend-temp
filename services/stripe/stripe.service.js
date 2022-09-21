const stripeConfig = require('../../config/stripe.config');
const stripe = require('stripe')(stripeConfig.secret_key);
const BaseService = require('../base.service');

const { price_info } = require('../../db/models');

class StripeService extends BaseService {
  async createCheckoutSession({ priceId, businessId }) {
    try {
      const session = await stripe.checkout.sessions.create({
        mode: 'subscription',
        payment_method_types: ['card'],
        line_items: [
          {
            price: priceId,
            quantity: 1,
          },
        ],
        success_url: 'http://192.168.107.81:3000/success-payment/{CHECKOUT_SESSION_ID}',
        cancel_url: 'http://avamgt.com/select-plan',
      });
      return this.successResponse(session.id);
    } catch (e) {
      console.log(e);
      return this.errorResponse(e);
    }
  }
  async getPaymentHistory(customer_id) {
    let invoices = await stripe.invoices.list({
      customer: customer_id,
      status: 'paid',
    });
    return invoices.data;
  }
  async getPrice(id) {
    const price = await stripe.prices.retrieve(id);
    return price;
  }
  async createCustomer({ email, firstname, lastname }) {
    const customer = await stripe.customers.create({
      description: `${firstname} ${lastname}`,
      email: email,
      metadata: {
        firstname: firstname,
        lastname: lastname,
      },
    });
    return customer;
  }
  async createSubscription(customerId, priceId) {
    const subscription = await stripe.subscriptions.create({
      customer: customerId,
      items: [
        {
          price: priceId,
        },
      ],
      payment_behavior: 'default_incomplete',
      expand: ['latest_invoice.payment_intent'],
    });

    return subscription;
  }
}
module.exports = new StripeService();
