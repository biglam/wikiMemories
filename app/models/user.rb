class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :memories
  has_many :links
  has_many :flags
  has_many :images
  has_many :people_adminstrations, foreign_key: "adminstrator_id"
  has_many :adminstered_people, through: :people_adminstrations, source: :person
  has_many :place_administrations, foreign_key: "administrator_id"
  has_many :administered_places, through: :place_administrators, source: :place
  has_many :pets_administrations, foreign_key: "administrator_id"
  has_many :administered_pets, through: :pets_administrations, source: :pet
  has_many :occasions_administrations, foreign_key: "administrator_id"
  has_many :administered_occasions, through: :occasions_administrations, source: :occasion
  has_and_belongs_to_many :messages

  validates :username, presence: true
  validates :email, presence: true

  def average_ranking
    if memories.count > 0
      rankings = memories.map {|m| m.ranking }
      (rankings.inject{ |sum, el| sum + el }.to_f / rankings.size).round
    else
      0
    end
  end

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end

  def messages
    Message.where("messages.sender_id = :id OR messages.reciever_id = :id", id: id).order(:created_at)
  end

  def unread_message_count
    # Message.where("messages.reciever_id = :id AND messages.read = false", id: id).count
    self.messages.where(read: false).count
  end

end
