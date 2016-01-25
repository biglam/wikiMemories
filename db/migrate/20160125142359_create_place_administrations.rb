class CreatePlaceAdministrations < ActiveRecord::Migration
  def change
    create_table :place_administrations do |t|
      t.integer :place_id
      t.integer :administrator_id

      t.timestamps null: false
    end
  end
end
