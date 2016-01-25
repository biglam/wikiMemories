class CreateLinksPets < ActiveRecord::Migration
  def change
    create_table :links_pets do |t|
      t.integer :link_id
      t.integer :pet_id

      t.timestamps null: false
    end
  end
end
