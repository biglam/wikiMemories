class CreateOccasions < ActiveRecord::Migration
  def change
    create_table :occasions do |t|
      t.string :name
      t.date :date
      t.time :time

      t.timestamps null: false
      create_join_table :memories, :occasions
    end
  end
end
