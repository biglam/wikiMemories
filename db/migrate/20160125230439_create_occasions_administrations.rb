class CreateOccasionsAdministrations < ActiveRecord::Migration
  def change
    create_table :occasions_administrations do |t|
      t.integer :occasion_id
      t.integer :administrator_id

      t.timestamps null: false
    end
  end
end
