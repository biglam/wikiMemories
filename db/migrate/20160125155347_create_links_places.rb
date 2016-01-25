class CreateLinksPlaces < ActiveRecord::Migration
  def change
    create_table :links_places do |t|
      t.integer :link_id
      t.integer :place_id

      t.timestamps null: false
    end
  end
end
