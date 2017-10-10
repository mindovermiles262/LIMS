class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :projects
  has_many :samples, through: :projects

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true #TODO: Add email validation

  def initials
    self.first_name[0].to_s + self.last_name[0].to_s
  end

  def full_name
    self.first_name.capitalize + " " + self.last_name.capitalize
  end

  # def all_tests # unused function (?) AD 09/25/17
  #   tests = Array.new
  #   self.projects.each do |proj|
  #     proj.tests.each do |test|
  #       tests << test
  #     end
  #   end
  #   tests
  # end
end
