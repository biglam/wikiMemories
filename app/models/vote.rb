class Vote < ActiveRecord::Base
  validates_inclusion_of :value, in: -2..2

  def vote_is_eligable(item, user)
    if item.votes.where("created_at >= ?", Time.zone.now-3600).count == 0
      # binding.pry;''
      true
    end
  end

  def add_vote_to_item(item, user, value)
    if vote_is_eligable(item, user)
      self.memory_id = item.id if item.class==Memory
      self.image_id = item.id if item.class==Image
      self.user_id = user.id
      self.value = value
      self.save
    else
      "You are not eligable to vote"
    end
  end

end
