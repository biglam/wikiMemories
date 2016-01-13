class ChangeDodToDiedInPets < ActiveRecord::Migration
  def change
  	  	rename_column :pets, :dod, :died
  end
end
