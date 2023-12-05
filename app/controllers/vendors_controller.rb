class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :index]

  before_action :authenticate_vendor!, only: [:show, :index]

  def index
    @vendor_products = current_vendor.products
  end

  def new
    @product = current_vendor.products.build
  end

  def create
    @vendor_products = @vendor.products.build(vendor_params)
    if @vendor_products.save
      redirect_to vendor_path(@vendor), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # def show
  #   byebug
  #   @product = @vendor.products.find(params[:id])
  #   # @order = current_user.orders.build
  #   # @vendor_products = @vendor.products.includes(:vendor_product)
  # end

  def show
    if current_vendor.present?
      @vendor_product = current_vendor.products || vendors
      byebug
      if @vendor_product.nil?
        redirect_to root_path, alert: 'vendor not found or not placed.'
      end
    else
      @products = Product.all
    end
  end

  private

  def set_vendor
    @vendor = current_vendor
  end

  def vendor_params
    params.require(:product).permit(:title, :description, :price)
  end

  def vendors
   if current_vendor.placed_orders
    @product = current_vendor.products.where(id: params[:id])
   end
  end
end
