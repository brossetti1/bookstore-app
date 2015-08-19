class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn, limit: 13
      t.text :description
      t.date :published_at
      t.references :publisher, index: true, foreign_key: true
      t.integer :page_count
      t.decimal :price, precision: 16, scale: 2

      t.timestamps null: false
    end
  end
end
