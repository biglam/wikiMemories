class Vote < ActiveRecord::Base
  # validates_inclusion_of :value, in: -2..2
  belongs_to :memory
  belongs_to :image

  def vote_is_eligable(item, user)
    # binding.pry;''
    if user_has_voted(item, user) && user_last_voted_less_than_an_hour_ago(item, user)
      false
    else
      true
    end

    # if item.votes.where("created_at >= ?", Time.zone.now-3600).count == 0
    #   true
    # end
  end

  def add_vote_to_item(item, user, value)
    # binding.pry;''
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

  def user_has_voted(item, user)
    item.votes.where(user_id: user.id).count > 0
  end

  def user_last_voted_less_than_an_hour_ago(item, user)
    item.votes.where(user_id: user.id).order(:created_at).last.created_at > 1.hour.ago
  end

end
