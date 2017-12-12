class ApplicationController < ActionController::API


  include DeviseTokenAuth::Concerns::SetUserByToken

  include Response
  include HandlingExceptions

  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      if current_user
        if Order.where(:account_id => current_user.id, :status => 'new').any?
          x = Order.where(:account_id => current_user.id, :status => 'new')
          Order.find(x.first.id)
        else
          Order.new(:account_id => current_user.account.id, :status => 'new')
        end
      else
        Order.new
      end
    end
  end
end
