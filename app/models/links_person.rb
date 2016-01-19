class LinksPerson < ActiveRecord::Base
  belongs_to :person
  belongs_to :link
end
