class AddDefaultToRanking < ActiveRecord::Migration
  def change
    change_column :memories, :ranking, :integer, default: 0
  end
end
