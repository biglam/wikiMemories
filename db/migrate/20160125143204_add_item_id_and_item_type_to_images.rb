class AddItemIdAndItemTypeToImages < ActiveRecord::Migration
  def change
    add_column :images, :image_item_id, :integer
    add_column :images, :image_item_type, :string
  end
end
