class AddDescriptionToOccasion < ActiveRecord::Migration
  def change
    add_column :occasions, :description, :text
  end
end
