require 'rspec'
require 'faker'
require_relative '../app/models/teacher'
require_relative '../app/models/student'

#      t.string :name
#      t.string :email
#      t.string :phone

describe Teacher, "validations" do

  before(:all) do
    #create our test teacher here
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:students).should be_true
    Teacher.delete_all

    @teachers = []

    counter = 0
    9.times do
      counter +=1
      @teachers << Teacher.create(
        :name => "John Snow" + counter.to_s,
        :email =>  "crow@thewall" + counter.to_s + ".com",
        :phone => "314-256-775" + counter.to_s)
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

  it "should be possible to find a teacher given a student" do
    @new_student = Student.create(
      :birthday => Time.new(1981,11,01),
      :teacher_id => Teacher.all.last.id)

    Teacher.find_by_id(@new_student.teacher_id).should == Teacher.all.last        
  end

  it "should be possible to find all students belonging to a teacher" do
    @newer_student = Student.create(
      :birthday => Time.new(1980,12,25),
      :teacher_id => Teacher.all.last.id)

    @newest_student = Student.create(
      :birthday => Time.new(1981,11,01),
      :teacher_id => Teacher.all.last.id)

    Student.find_all_by_teacher_id(Teacher.all.last.id).should ==
      [@newer_student, @newest_student]
  end
end





