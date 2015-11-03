class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
