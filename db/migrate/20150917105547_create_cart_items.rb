class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.references :cart, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.decimal :price, precision: 4, scale: 2
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
