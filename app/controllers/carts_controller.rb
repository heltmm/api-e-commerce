class CartsController < ApplicationController
def show
    @order_items = current_order.order_items
    @products = []
    @order_items.each do |order_item|
      @products.push([order_item.product, order_item.quantity])
    end
    render :json => {
         :products => @products,
         :total => current_order.total_price
      }.to_json
  end
end
