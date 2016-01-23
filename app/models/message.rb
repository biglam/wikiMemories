class Message < ActiveRecord::Base

	belongs_to :sender, class_name: 'User'
	belongs_to :reciever, class_name: 'User'

	scope :with, ->(user) { where("messages.sender_id = :id OR messages:reciever_id :id", id: user.id)}

end
