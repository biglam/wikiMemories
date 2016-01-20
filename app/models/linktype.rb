class Linktype < ActiveRecord::Base
  has_many :links
  validates :linktype, presence: true
end
