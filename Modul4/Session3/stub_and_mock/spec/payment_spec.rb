require_relative '../src/Payment'
require_relative '../src/PaymentGateway'
require_relative '../src/Logger'

describe Payment do
  it 'records the payment' do
    payment_gateway = double()
    allow(payment_gateway).to receive(:charge).and_return(payment_id: 1234)

    logger = double()
    expect(logger).to receive(:record_payment).with(1234)

    payment = Payment.new(payment_gateway, logger)
    payment.total_cents = 1800
    payment.save
  end
end


# describe Payment do
#   it 'records the payment' do
#     payment_gateway = PaymentGateway.new
#     logger = Logger.new
#     payment = Payment.new(payment_gateway, logger)
#     payment.total_cents = 1800
#     payment.save
#   end
# end