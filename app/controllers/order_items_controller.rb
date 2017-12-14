class OrderItemsController < ApplicationController

  def create
    binding.pry

    @order = current_order
    @item = @order.order_items.new(quantity: params['quantity'],
                                  product_id: params['product_id'])
    @order.save
    session[:order_id] = @order.id
    json_response(@order, :created)
  end

  def destroy
    @order = current_order
    @item = @order.order_items.find(params[:id])
    @item.destroy
    if @order.save
      render status: 200, json: {
        message: "Your Item has been successfully removed."
      }
    end
  end

  def update
    @order_item = current_order.order_items.find(params[:id])
    @order_item.update(:quantity => params[:quantity])
    if current_order.save
      render status: 200, json: {
        message: "Your Item has been successfully updated."
      }
    end
  end

public

  def item_params
    params.permit('access-token', :client, :expiry, :tokenType, :uid, :product_id, :quantity)
  end
end
