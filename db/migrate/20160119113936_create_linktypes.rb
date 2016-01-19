class CreateLinktypes < ActiveRecord::Migration
  def change
    create_table :linktypes do |t|
      t.string :linktype

      t.timestamps null: false
    end
  end
end
