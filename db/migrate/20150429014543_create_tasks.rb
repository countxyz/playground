class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.timestamps null: false

      t.string   :title,       null: false
      t.text     :description, null: false
      t.datetime :deadline
      t.boolean  :complete,    default: true, null: false
      t.datetime :completed_at

      t.index :created_at, order: :asc
      t.index :complete,   where: false

      t.references :user, index: true
    end
  end
end
