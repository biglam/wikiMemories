class Image < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :voted_item

  belongs_to :image_item, :polymorphic => true

  mount_uploader :image, ImageUploader
 
  # validates :title, presence: true
  # validates :url, presence: true
  # validates :user_id, presence: true


  def reset_flag_count
    Flag.create(memory_id: self.id, user_id: user.id, message: "Flagcount Reset by administrator #{user.username}")
    self.flagcount = 0
    self.save
  end

  def update_ranking_from_votes
    self.ranking = self.votes.map {|vote| vote.value }.reduce {|sum, num| sum+num}
    self.save
  end

end
