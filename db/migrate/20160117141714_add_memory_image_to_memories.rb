class AddMemoryImageToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :memory_image, :string
  end
end
