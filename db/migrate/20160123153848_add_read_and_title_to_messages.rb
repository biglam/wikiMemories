class AddReadAndTitleToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :read, :boolean, :default => false
    add_column :messages, :title, :string
  end
end
