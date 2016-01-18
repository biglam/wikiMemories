class DropColumnRankingstrFromImages < ActiveRecord::Migration
  def change
  	remove_column :images, :rankingstr
  end
end
