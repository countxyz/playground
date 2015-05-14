class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.timestamps null: false

      t.integer :quantity,    default: 1
      t.decimal :unit_price,  precision: 8, scale: 2
      t.decimal :total_price, precision: 8, scale: 2

      t.references :product, index: true
    end
  end
end
