class AddPlaceOfBirthAndBriefDescriptionToPerson < ActiveRecord::Migration
  def change
    add_column :people, :place_of_birth, :string
    add_column :people, :died_of, :string
    add_column :people, :brief_description, :string
  end
end
