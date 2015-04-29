class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.timestamps null: false

      t.string :first_name,             null: false
      t.string :last_name,  default: '', null: false
      t.string :company,    default: '', null: false
      t.text   :notes,      default: '', null: false

      t.index :created_at, order: :desc

      t.references :user, index: true
    end
  end
end
