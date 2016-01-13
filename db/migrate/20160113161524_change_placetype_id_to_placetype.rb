class ChangePlacetypeIdToPlacetype < ActiveRecord::Migration
  def change
  	rename_column :places, :placetype, :placetype_id
  end
end
