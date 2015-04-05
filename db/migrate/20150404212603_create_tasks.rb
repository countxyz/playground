class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.timestamps null: false

      t.string   :title,       null: false
      t.text     :description, null: false
      t.datetime :deadline
      t.datetime :completed

      t.references :user, index: true
    end
  end
end
