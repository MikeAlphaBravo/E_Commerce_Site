class ProductsController < ApplicationController
  def index
    @products = Product.all
    @order_item = current_order.order_items.new
    # API CALL
    @response = RestClient.get('https://api.nytimes.com/svc/books/v3/lists/combined-print-and-e-book-fiction.json', headers= {api_key: ENV['NYT_API_KEY']})
    binding.pry
  end
end
