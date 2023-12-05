class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_products = @user.products
  end

  def user_order
    @user = User.find(params[:id])
    @order = Order.new
  end
end
