class AddGroupIdToGroups < ActiveRecord::Migration
  def change
    add_column :group_items, :group_id, :integer
  end
end
