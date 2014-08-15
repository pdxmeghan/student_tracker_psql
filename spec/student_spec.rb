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

  it 'will update a students name' do
    test_student = Student.new({'name' => 'Forest Gump', 'student_number' => 1345})
    test_student.save
    test_student.update_name('Forrest Gump')
    expect(test_student.name).to eq 'Forrest Gump'
  end

  it 'will update a students student number' do
    test_student = Student.new({'name' => 'Forerst Gump', 'student_number' => 1344})
    test_student.save
    test_student.update_number(1345)
    expect(test_student.student_number).to eq 1345
  end

  it 'will delete a student from the database' do
    test_student = Student.new({'name' => 'Forrest Gump', 'student_number' => 1345})
    test_student.save
    test_student.delete_student
    expect(Student.all).to eq []
  end

  it 'will list all courses a student is enrolled in' do
    test_student = Student.new({'name' => 'Jenny', 'student_number' => 3487})
    test_student.save
    test_course = Course.new({'name' => 'Underwater Basketweaving', 'course_number' => 'AC489'})
    test_course.save
    test_course.add_student(test_student)
    expect(test_student.list_courses).to eq [test_course]
  end
end
