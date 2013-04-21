require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class ModifyStudents < ActiveRecord::Migration
  def change
    change_table(:students) do |t|
      t.references :teacher  #creates foreign key of teacher_id.
    end
  end
end