class CreateGroupJoinTables < ActiveRecord::Migration
  def change
  	create_join_table :groups, :memories
  	create_join_table :groups, :occasions
  	create_join_table :groups, :people
  	create_join_table :groups, :pets
  	create_join_table :groups, :places
  end
end
