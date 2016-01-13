class Person < ActiveRecord::Base

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
