class Message < ActiveRecord::Base

	belongs_to :sender, class_name: 'User'
	belongs_to :reciever, class_name: 'User'

	scope :with, ->(user) { where("messages.sender_id = :id OR messages.reciever_id = :id", id: user.id).order(created_at: :desc) }
  scope :unread, -> { where(read: false) }
  scope :received, ->(user) { where(reciever_id: user.id) }

end
