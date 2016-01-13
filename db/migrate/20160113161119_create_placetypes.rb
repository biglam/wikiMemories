class CreatePlacetypes < ActiveRecord::Migration
  def change
    create_table :placetypes do |t|
      t.string :placetype

      t.timestamps null: false
    end
  end
end
