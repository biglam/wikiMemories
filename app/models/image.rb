class Image < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  has_many :images_people
  has_many :people, through: :images_people
  mount_uploader :image, ImageUploader


   def rank_up
   	# binding.pry;''
      self.ranking += 1
      self.save
  end

  def rank_down
      self.ranking -= 1
      self.save
  end

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
