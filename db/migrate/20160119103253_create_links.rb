class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.text :address
      t.integer :user_id
      t.integer :linktype_id
      t.integer :flagcount, default: 0

      t.timestamps null: false
    end
  end
end
