class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :projects
  has_many :tests, through: :projects

  def initials
    self.first_name[0].to_s + self.last_name[0].to_s
  end

  def all_tests
    tests = Array.new
    self.projects.each do |proj|
      proj.tests.each do |test|
        tests << test
      end
    end
    tests
  end
end
