class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "product_id", "quantity", "status", "updated_at", "user_id"]
  end
end
