class AddVotedItemIdAndVotedItemTypeToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :voted_item_id, :integer
    add_column :votes, :voted_item_type, :string
  end
end
