class CreateGroupItems < ActiveRecord::Migration
  def change
    create_table :group_items do |t|
      t.integer :item_id
      t.string :item_type

      t.timestamps null: false
    end
  end
end
