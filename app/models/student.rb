require_relative '../../db/config'
require 'date'

class StudentValidator < ActiveModel::Validator
  def validate(record)
    return true if self.age > 4
    record.errors[:base] << "Sorry, no toddlers."
  end
end

class Student < ActiveRecord::Base

  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
            :uniqueness => true
  # validates :age

  def name
    "#{first_name} #{last_name}"
  end

  def age
    now = Date.today

    age = now.year - birthday.year - ((now.month > birthday.month || 
         (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end
end


s = Student.new({ :birthday => Date.new(2012,1,13) })
puts s[:birthday].year
puts s.age

