class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.timestamps null: false

      t.string :phone_number, null: false

      t.string :type, null: false

      t.references :phoneable, index: true, polymorphic: true
    end
  end
end
