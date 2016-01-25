class CreateLinksOccasions < ActiveRecord::Migration
  def change
    create_table :links_occasions do |t|
      t.integer :link_id
      t.integer :occasion_id

      t.timestamps null: false
    end
  end
end
