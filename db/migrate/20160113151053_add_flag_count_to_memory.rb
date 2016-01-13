class AddFlagCountToMemory < ActiveRecord::Migration
  def change
    add_column :memories, :flagcount, :integer, default: 0
  end
end
