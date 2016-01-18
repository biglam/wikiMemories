class Image < ActiveRecord::Base
  belongs_to :user
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

end
