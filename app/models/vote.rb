class Vote < ActiveRecord::Base
  # validates_inclusion_of :value, in: -2..2
  belongs_to :memory
  belongs_to :image
  belongs_to :voted_item, polymorphic: true ## needs `voted_item_id` and `voted_item_type` fields
  belongs_to :user

  validates :user_id, presence: :true
  validate :vote_is_eligable

  # def self.new_for_item(item, user, value)
  #   # binding.pry;''
  #   vote = new(user: user, value: value)
  #   vote.memory = item if item.is_a? Memory
  #   vote.image = item if item.is_a? Image
  #   vote
  # end

  def user_has_voted(item, user)
    item.votes.where(user_id: user.id).count > 0 if user
  end

  def user_last_voted_less_than_an_hour_ago(item, user)
    item.votes.where(user_id: user.id).order(:created_at).last.created_at > 1.hour.ago
  end


  private
  def vote_is_eligable
    # item = memory || image
    if user_has_voted(voted_item, user) && user_last_voted_less_than_an_hour_ago(voted_item, user)
      errors.add :base, "You are not eligable to vote"
    end
  end

end
