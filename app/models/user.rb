class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :products, through: :orders
  has_one :cart

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "products", "cart"]
  end

  # def self.ransackable_attributes(auth_object = nil)
  #   ["created_at", "id", "product_id", "quantity", "status", "updated_at", "user_id"]
  # end
end
