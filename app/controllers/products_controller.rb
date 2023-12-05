class ProductsController < ApplicationController
  before_action :authenticate_vendor!

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    # @order = current_user.orders.build
  end

  def new
    @product = current_vendor.products.create
  end

  def create
    @product = current_vendor.products.build(product_params)
    @product.image.attach(params[:product][:image])

    if @product.save
      redirect_to vendors_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @product = current_vendor.products.find(params[:id])
    if @product.destroy
      redirect_to vendors_path, notice: 'Product was successfully deleted.'
    else
      redirect_to vendors_path, alert: 'Unable to delete the product.'
    end
end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :image)
  end
end
