class CartsController < ApplicationController

  before_action :authenticate_user!

  def show
    @cart = current_user.cart
    @products = @cart.products.includes(:product)
  end

  def create
    @cart = current_user.build_cart
    if @cart.save
      redirect_to @cart, notice: 'Cart was successfully created.'
    else
      redirect_back fallback_location: root_path, alert: 'Unable to create cart.'
    end
  end

  def destroy
    @cart = current_user.cart
    @cart.destroy
    redirect_to root_path, notice: 'Cart was successfully destroyed.'
  end
end
