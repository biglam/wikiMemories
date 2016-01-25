class CreatePetsAdministrations < ActiveRecord::Migration
  def change
    create_table :pets_administrations do |t|
      t.integer :pet_id
      t.integer :administrator_id

      t.timestamps null: false
    end
  end
end
