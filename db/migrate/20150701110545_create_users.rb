class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps null: false

      t.string   :email,                            null: false
      t.string   :first_name,       default: '',    null: false
      t.string   :last_name,        default: '',    null: false
      t.string   :password_digest
      t.boolean  :activated,        default: false, null: false
      t.string   :activation_digest
      t.datetime :activated_at
      t.boolean  :admin,            default: false, null: false

      t.index :email, unique: true
    end
  end
end
