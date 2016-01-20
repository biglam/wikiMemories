class Flag < ActiveRecord::Base
  belongs_to :memory
  belongs_to :user

  validates :message, presence: true
end
