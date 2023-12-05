class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  # vendor_id = current_vendor.id

  # orders = Order.joins(:product).where(products: { vendor_id: vendor_id })

  def index
    if current_user.present?
      @orders = current_user.orders
    # elsif current_vendor.present?
    #   @orders = current_vendor.orders
    else current_vendor.present?
      byebug
      @orders = Order.joins(:product).where(products: { vendor_id: current_vendor.id })
    end
  end

  # def user_orders
  #   byebug
  #   @product = Product.find(params[:product_id])
  #   @order = current_user.orders.new(
  #     product: @product,
  #     quantity: order_params[:quantity],
  #     status: 'pending'
  #   )

  #   if @order.save
  #     redirect_to @order, notice: 'Order was successfully created.'
  #   else
  #     render 'products/show'
  #   end
  # end

  def create
    byebug
    @product = Product.find(params[:product_id])
    @order = current_user.orders.new(
      product: @product,
      quantity: order_params[:quantity],
      status: 'placed'
    )

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render 'products/show'
    end
  end

  def new
    @order = Order.new(Product.find(params[:product_id]))
  end

  # def show
  #   if current_user.present?
  #     @order = current_user.orders.where(params[:id])
  #   else
  #     @products = Product.all
  #   end
  # end

  def show
    byebug
    if current_user.present?
      @order = current_user.orders.where(id: params[:id])
      if @order.nil?
        redirect_to root_path, alert: 'Order not found or not placed.'
      end
    else
      @products = Product.all
    end
  end

  # def placed_orders
  #   @placed_orders = Order.where(status: 'placed')
  #   render json: @placed_orders, status: :ok
  # end

  private

  def order_params
    params.require(:order).permit(:quantity)
  end
end
