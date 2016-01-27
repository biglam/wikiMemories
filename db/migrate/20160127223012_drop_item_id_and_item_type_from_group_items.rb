class DropItemIdAndItemTypeFromGroupItems < ActiveRecord::Migration
  def change
  	remove_column :group_items, :item_id
   	remove_column :group_items, :item_type

  end
end
