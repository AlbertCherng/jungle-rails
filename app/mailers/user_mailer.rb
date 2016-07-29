class UserMailer < ApplicationMailer

  default from: 'no-reply@jungle.com'

  def order_receipt(order)
    @order = order
    @user = order.email
    @url  = 'http://example.com/login'
    mail(to: @user, subject: 'Your Orders')
  end

end
