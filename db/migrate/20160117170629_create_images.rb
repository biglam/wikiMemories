class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.string :title
      t.string :ranking, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
