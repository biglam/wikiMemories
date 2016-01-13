class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.integer :placetype
      t.string :lat
      t.string :lng

      t.timestamps null: false
    end
  end
end
