class RenameRankingToRankingStrInImages < ActiveRecord::Migration
  def change
  	rename_column :images, :ranking, :rankingstr
  end
end
