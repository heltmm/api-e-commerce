class OrderItemsController < ApplicationController
  def index
    binding.pry
  end
  def create
    binding.pry
    @order = current_order
    @item = @order.order_items.new(item_params)
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

private

  def item_params
    params.permit(:quantity, :product_id)
  end
end
