class CreateJoinTableMemoriesPeople < ActiveRecord::Migration
  def change
  	create_join_table :memories, :people
  end
end
