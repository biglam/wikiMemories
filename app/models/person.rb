class Person < ActiveRecord::Base
	belongs_to :charity

	has_many :people_adminstrations
	has_many :adminstrators, through: :people_adminstrations
	has_many :images, :as => :image_item
	has_many :links_people
	has_many :links, through: :links_people
	has_and_belongs_to_many :memories
	has_many :group_items, :as => :groupable
	has_many :groups, through: :group_items


	validates :lastname, presence: true
	# validates 
	def fullname
		if middlenames == nil 
			"#{firstname} #{lastname}"
		else
			"#{firstname} #{middlenames} #{lastname}"
		end
	end

	def age
		if died == nil
			from = Time.now.utc.to_date
		else 
			from = died
		end
		from.year - dob.year - (dob.to_date.change(:year => from.year) > from ? 1 : 0)
	end

	def get_top_image
		self.images.order('ranking DESC')[0].image
	end

	def can_admin(user)
		if user
			list = self.adminstrators.map {|admin| admin.id}
			list.include?(user.id)
		end
	end

	def remove_item(item)
		# binding.pry;''
		self.adminstrators.delete(item) if item.class == User
		self.save
	end

end
