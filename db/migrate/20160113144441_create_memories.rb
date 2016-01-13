class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.string :title
      t.text :story
      t.integer :ranking
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
