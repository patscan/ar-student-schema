class Teacher < ActiveRecord::Base
  
  validates :email, :uniqueness => true
end