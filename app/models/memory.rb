class Memory < ActiveRecord::Base
	belongs_to :user
  has_many :flags
	has_and_belongs_to_many :people
	has_and_belongs_to_many :pets
	has_and_belongs_to_many :places
	has_and_belongs_to_many :occasions
	has_and_belongs_to_many :groups
  has_many :votes

  # mount_uploader :memory_image, MemoryImageUploader

  # def rank_up
  #     self.ranking += 1
  #     self.save
  # end

  # def rank_down
  #     self.ranking -= 1
  #     self.save
  # end

  def reset_flag_count
    Flag.create(memory_id: self.id, user_id: user.id, message: "Flagcount Reset by administrator #{user.username}")
    self.flagcount = 0
    self.save
  end

  def add_associate(ptype, pid)
    # binding.pry;''
    case ptype
    when "Person"
      self.people << Person.find(pid)
    end
  end

  def flag_memory(params)
    flag = Flag.new
    flag.memory_id = params[:flag][:memory_id]
    flag.user_id = params[:flag][:user_id]
    flag.message = params[:flag][:message]
    flag.save
    self.flagcount += 1
    self.save
  end

  def update_ranking_from_votes
    self.ranking = self.votes.map {|vote| vote.value }.reduce {|sum, num| sum+num}
    self.save
  end

end
