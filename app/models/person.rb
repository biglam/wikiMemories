class Person < ActiveRecord::Base
	belongs_to :charity
	has_many :people_adminstrations
	has_many :adminstrators, through: :people_adminstrations
	has_and_belongs_to_many :memories
	has_and_belongs_to_many :groups

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
end
