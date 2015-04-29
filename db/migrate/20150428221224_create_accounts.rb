class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.timestamps null: false

      t.string  :name,                    null: false
      t.string  :website, default: '',    null: false
      t.text    :notes,   default: '',    null: false
      t.boolean :active,  default: true,  null: false
      t.string  :slug,                    null: false

      t.index :name,       unique: true
      t.index :slug,       unique: true
      t.index :created_at, order: :desc

      t.references :user, index:  true
    end
  end
end
