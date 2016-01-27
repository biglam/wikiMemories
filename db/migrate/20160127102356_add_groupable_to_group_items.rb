class AddGroupableToGroupItems < ActiveRecord::Migration
  def change
    add_reference :group_items, :groupable, polymorphic: true
  end
end
