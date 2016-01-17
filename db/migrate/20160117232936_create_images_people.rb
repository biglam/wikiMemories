class CreateImagesPeople < ActiveRecord::Migration
  def change
    create_table :images_people do |t|
      t.integer :image_id
      t.integer :person_id

      t.timestamps null: false
    end
  end
end
