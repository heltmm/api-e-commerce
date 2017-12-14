class ApplicationController < ActionController::API


  include DeviseTokenAuth::Concerns::SetUserByToken


  include Response
  include HandlingExceptions

  def current_order
    if !current_user.account
      Account.create!(user_id: current_user.id)
    end
    if current_user.account.orders.last
      if current_user.account.orders.last.status === 'pending'
      current_user.account.orders.last
      end
    else
      current_user.account.orders.new(:status => 'pending')
    end
  end

  def attach_order
    if !current_user.account
      Account.create!(user_id: current_user.id)
    end
    order = current_order
    # If a user has NO orders OR NO 'in progress' and current_order is saved order we update current order to the user's account if current_order is not saved we save current order to the user's acout.
    if (!does_user_have_order?) || (!user_in_progress_order?)
      order_saved?(order) ? order.update(account_id: current_user.account.id) : Order.create(account_id: current_user.account.id)
      session[:order_id] = current_user.orders.last.id
    # If there are NO items in the current_order AND the user's account has an in progress order then make the 'in progress' order the current_order
    elsif (!items_in_order?) and (user_in_progress_order?)

      session[:order_id] = current_user.account.orders.last.id
      # We (ass)ume that there are items in the current_order AND the user has an order 'in progress'

    else
      order.order_items.each do |order_item|
        current_user.account.orders.last.update_order(order_item)
      end
      Order.find(current_order.id).destroy
      session[:order_id] = current_user.account.orders.last.id
    end
  end

  def after_sign_in_path_for(resource)
    attach_order
    products_path
  end

  def does_user_have_order?
    current_user.account.orders.any?
  end

  def user_in_progress_order?
    current_user.account.orders.last.status === "In progress"
  end

  def items_in_order?
    current_order.order_items.first
  end

  def order_saved?(order)
    order.id
  end

end
