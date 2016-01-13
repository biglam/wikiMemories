class CreateJoinTableMemoriesEtc < ActiveRecord::Migration
  def change
  	create_join_table :memories, :places
  	create_join_table :memories, :pets
  end
end
