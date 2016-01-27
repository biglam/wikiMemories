class Group < ActiveRecord::Base

  has_many :group_items
  validates :name, presence: true

end
