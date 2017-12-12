class CartsController < ApplicationController
def show
    @order_items = current_order.order_items.sort
    json_response(@order_items)
  end
end
