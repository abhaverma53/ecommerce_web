class Product < ApplicationRecord
 belongs_to :vendor
 has_one_attached :image
 validates :image, presence: true
 has_many :orders, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "price", "title", "updated_at", "vendor_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "vendor", "image_attachment_id_eq"]
  end
end
