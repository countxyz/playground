class Admin::ProductsController < Admin::BaseController

  def index
    @products   = Product.includes :category, :user
    @categories = Category.all
  end
end
