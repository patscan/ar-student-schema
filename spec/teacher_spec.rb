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

describe Student, "validations" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:students).should be_true
    Student.delete_all
  end

  before(:each) do
    @student = Student.new
    @student.assign_attributes ({
      :first_name => "Kreay",
      :last_name => "Shawn",
      :birthday => Date.new(1989,9,24),
      :gender => 'female',
      :email => 'kreayshawn@oaklandhiphop.net',
      :phone => '(510) 555-1212 x4567'})
  end

  it "should accept valid info" do
    @student.should be_valid
  end

  it "shouldn't accept invalid emails" do
    ["XYZ!bitnet", "@.", "a@b.c"].each do |address|
      @student.assign_attributes(:email => address)
      @student.should_not be_valid
    end
  end

  it "should accept valid emails" do
    ["joe@example.com", "info@bbc.co.uk", "bugs@devbootcamp.com"].each do |address|
      @student.assign_attributes(:email => address)
      @student.should be_valid
    end
  end

  it "shouldn't accept toddlers" do
    @student.assign_attributes(:birthday => Date.today - 3.years)
    @student.should_not be_valid
  end

  it "shouldn't allow two students with the same email" do
    another_student = Student.create!(
      :birthday => @student.birthday,
      :email => @student.email,
      :phone => @student.phone
    )
    @student.should_not be_valid
  end

end

describe Student, "advanced validations" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:students).should be_true
    Student.delete_all
  end

  before(:each) do
    @student = Student.new
    @student.assign_attributes(
      :first_name => "Kreay",
      :last_name => "Shawn",
      :birthday => Date.new(1989,9,24),
      :gender => 'female',
      :email => 'kreayshawn@oaklandhiphop.net',
      :phone => '(510) 555-1212 x4567'
    )
  end

  it "should accept valid info" do
    @student.should be_valid
  end

  it "shouldn't accept invalid phone numbers" do
    @student.assign_attributes(:phone => '347-8901')
    @student.should_not be_valid
  end

end
