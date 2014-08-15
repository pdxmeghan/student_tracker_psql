require 'spec_helper'

describe Student do
  it 'will initialize with a new student, with name and student id number' do
    test_student = Student.new({'name' => 'Forrest Gump', 'student_number' => 1345})
    expect(test_student).to be_an_instance_of Student
  end

  it 'will read out the information for a student' do
    test_student = Student.new({'name' => 'Forrest Gump', 'student_number' => 1345})
    expect(test_student.name).to eq 'Forrest Gump'
    expect(test_student.student_number).to eq 1345
  end

  it 'will start out with an empty array' do
    expect(Student.all).to eq []
  end

  it 'will save a new Student to the database' do
    test_student = Student.new({'name' => 'Forrest Gump', 'student_number' => 1345})
    test_student.save
    expect(Student.all).to eq [test_student]
  end

  it 'will be the same student if they have the same name and student number' do
    test_student1 = Student.new({'name' => 'Forrest Gump', 'student_number' => 1345})
    test_student1.save
    test_student2 = Student.new({'name' => 'Forrest Gump', 'student_number' => 1345})
    test_student2.save
    expect(test_student1).to eq test_student2
  end
end
