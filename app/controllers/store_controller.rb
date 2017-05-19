class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @count = count
  end

  def count
    session[:counter] ||= 0
    session[:counter] += 1
  end
end
