class Pet < ActiveRecord::Base
	def age
		if died == nil
 			from = Time.now.utc.to_date
 		else 
 			from = died
 		end
  		from.year - dob.year - (dob.to_date.change(:year => from.year) > from ? 1 : 0)
	end

end
