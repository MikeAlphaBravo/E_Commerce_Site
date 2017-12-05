class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.decimal :total_price
      t.decimal :tax
      t.decimal :shipping
      t.decimal :subtotal
      t.integer :order_number
      t.integer :account_id
      t.timestamps
    end
  end
end
