class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :projects
  has_many :tests, through: :projects

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true #TODO: Add email validation

  def initials
    self.first_name[0].to_s + self.last_name[0].to_s
  end

  def full_name
    self.first_name.capitalize + " " + self.last_name.capitalize
  end
end
