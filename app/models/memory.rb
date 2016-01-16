class Memory < ActiveRecord::Base
	belongs_to :user
  has_many :flags
	has_and_belongs_to_many :people
	has_and_belongs_to_many :pets
	has_and_belongs_to_many :places
	has_and_belongs_to_many :occasions
	has_and_belongs_to_many :groups

  def rank_up
    self.ranking += 1
    self.save
  end

  def rank_down
    self.ranking -= 1
    self.save
  end
end
