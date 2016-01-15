class CreatePeopleAdminstrations < ActiveRecord::Migration
  def change
    create_table :people_adminstrations do |t|
      t.integer :person_id
      t.integer :adminstrator_id

      t.timestamps null: false
    end
  end
end
