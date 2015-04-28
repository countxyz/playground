class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps null: false

      t.string :email,                       null: false
      t.string :first_name,     default: '', null: false
      t.string :last_name,      default: '', null: false
      t.string :password_digest

      t.index :email, unique: true
    end
  end
end
