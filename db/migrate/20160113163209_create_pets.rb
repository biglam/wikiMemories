class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.date :dob
      t.date :dod

      t.timestamps null: false
    end
  end
end
