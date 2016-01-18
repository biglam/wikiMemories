class AddRankingToImages < ActiveRecord::Migration
  def change
    add_column :images, :ranking, :integer, default: 0
  end
end
