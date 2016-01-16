class Memory < ActiveRecord::Base
	belongs_to :user
  has_many :flags
	has_and_belongs_to_many :people
	has_and_belongs_to_many :pets
	has_and_belongs_to_many :places
	has_and_belongs_to_many :occasions
	has_and_belongs_to_many :groups

  def rank_up
    if user.id != self.user.id
      self.ranking += 1
      self.save
    else
      raise "You can't vote up your own memory"
    end
  end

  def rank_down
    if user.id != self.user.id
      self.ranking -= 1
      self.save
    else
      raise "You can't vote down your own memory"
    end
  end

  def reset_flag_count
    # binding.pry;''
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

end
