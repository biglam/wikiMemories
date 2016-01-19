class CreateLinksPeople < ActiveRecord::Migration
  def change
    create_table :links_people do |t|
      t.integer :link_id
      t.integer :person_id

      t.timestamps null: false
    end
  end
end
