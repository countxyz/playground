class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.timestamps null: false

      t.string     :title, null: false
      t.decimal    :price, default: 0.01, precision: 8, scale: 2

      t.references :user, index: true
    end
  end
end
