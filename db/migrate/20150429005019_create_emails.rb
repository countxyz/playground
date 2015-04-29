class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.timestamps null: false

      t.string :address, null: false

      t.references :emailable, index: true, polymorphic: true
    end
  end
end
