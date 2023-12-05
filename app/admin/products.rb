ActiveAdmin.register Product do
  permit_params :title, :description, :price, :vendor_id

  action_item :add_to_cart, only: :show do
    link_to 'Add to Cart', add_to_cart_admin_product_path(resource), method: :post
  end

  member_action :add_to_cart, method: :post do
    # Implement the logic to add the product to the cart here
    # For example:
    current_user.cart.products << resource

    redirect_to admin_product_path(resource), notice: 'Product added to cart successfully!'
  end

  # Other configurations...
end
