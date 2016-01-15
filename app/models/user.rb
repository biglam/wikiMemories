class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :memory
  has_many :people_adminstrations, foreign_key: "adminstrator_id"
  has_many :adminstered_people, through: :people_adminstrations, source: :person
end
