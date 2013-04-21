require 'rspec'
require 'faker'
require_relative '../app/models/teacher'

#      t.string :name
#      t.string :email
#      t.string :phone

describe Teacher, "validations" do

  before(:all) do
    #create our test teacher here
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:students).should be_true
    Teacher.delete_all

    @teachers = []

    9.times do
      @teachers << Teacher.create(
        :name =>  Faker::Name.name,
        :email => Faker::Internet.email,
        :phone => Faker::PhoneNumber.phone_number
        )
    end
  end

  it "should have a unique email address" do
    emails = []
    @teachers.each do |t|
      emails << t.email
    end

    duplicate_email = Teacher.create(
      :name => "Joe",
      :email => emails.last,
      :phone => '415-355-9843')
    
    duplicate_email.should_not be_valid
  end
end