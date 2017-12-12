class ProductsController < ApplicationController
  def index
    @products = Product.all
    json_response(@products)
  end
end
