class PeopleAdminstration < ActiveRecord::Base
  belongs_to :person
  belongs_to :adminstrator, class_name: "User"

end
