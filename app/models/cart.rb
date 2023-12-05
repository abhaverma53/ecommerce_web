class Cart < ApplicationRecord
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def add_product(product)
    current_item = line_items.find_by(product: product)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product: product, quantity: 1)
    end
     current_item
  end
end
