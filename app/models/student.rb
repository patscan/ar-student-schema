require_relative '../../db/config'
require 'date'

class Student < ActiveRecord::Base
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
            :uniqueness => true

  # attr_reader :id, :first_name, :last_name, :gender, :birthday, :email, :phone
  attr_accessible :id, :first_name, :last_name, :gender, :birthday, :email, :phone

  def name
    "#{:first_name} #{:last_name}"
  end

  def age
    now = Date.today
    age = now.year - :birthday.year - ((now.month > @birthday.month || (now.month == :birthday.month && now.day >= :birthday.day)) ? 0 : 1)
  end

end