class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.timestamps null: false

      t.decimal :total,  default: 0.00, precision: 8, scale: 2
      t.integer :status, default: 0

      t.references :user, index: true

      t.index :created_at, order: :desc
    end
  end
end
