class OrderMailer < ApplicationMailer
  def notify_on_successful_order(customer, order)
    @customer = customer
    @order = order

    mail to: @customer.email,
    subject: 'Order Confirmation'
  end
end
