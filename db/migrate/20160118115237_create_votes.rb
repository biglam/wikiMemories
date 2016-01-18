class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :memory_id
      t.integer :image_id
      t.integer :value

      t.timestamps null: false
    end
  end
end
