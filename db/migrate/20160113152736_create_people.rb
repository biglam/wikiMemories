class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :middlenames
      t.string :lastname
      t.date :dob
      t.date :died
      t.integer :charity_id

      t.timestamps null: false
    end
  end
end
