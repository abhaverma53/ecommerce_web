class AddDetailsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :product, null: false, foreign_key: true
    add_column :orders, :quantity, :integer, default: 1
    add_column :orders, :status, :string, default: 'pending'
  end
end
