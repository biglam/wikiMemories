class Memory < ActiveRecord::Base

  belongs_to :user
  has_many :flags
  has_and_belongs_to_many :people
  has_and_belongs_to_many :pets
  has_and_belongs_to_many :places
  has_and_belongs_to_many :occasions
  has_and_belongs_to_many :groups
  has_many :votes, as: :voted_item

  validates :title, presence: true
  validates :story, length: { minimum: 2 } 
  validates :story, length: { maximum: 1000 }
  validates :user_id, presence: true
  validates :story, uniqueness: {scope: :user_id}


  def reset_flag_count
    Flag.create(memory_id: self.id, user_id: user.id, message: "Flagcount Reset by administrator #{user.username}")
    self.flagcount = 0
    self.save
  end

  def add_associate(ptype, pid)
    case ptype
    when "Person"
      self.people << Person.find(pid)
    end
  end

  def remove_item(item)
    self.people.delete(item) if item.class==Person
    self.images.delete(item) if item.class==Image
    self.save
  end

  def add_flag
    self.flagcount += 1
  end

  def update_ranking_from_votes
    self.ranking = self.votes.map {|vote| vote.value }.reduce {|sum, num| sum+num}
    self.save
  end

  def count_items
    i = 0
    i += self.people.count
    i += self.pets.count
    i += self.places.count
    i += self.occasions.count
    i += self.groups.count
    i += self.flags.count
    i
  end

end
