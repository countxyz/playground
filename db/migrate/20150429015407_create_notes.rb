class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.timestamps null: false

      t.text :note, null: false

      t.references :noteable, index: true, polymorphic: true
    end
  end
end
