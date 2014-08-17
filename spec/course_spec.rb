require 'spec_helper'

describe Course do
  it 'will initialize with a name and course number' do
    test_course = Course.new({'name' => 'Cooking Shrimp', 'course_number' => 'CK306'})
    expect(test_course).to be_an_instance_of Course
  end

  it 'will read out the information of the course' do
    test_course = Course.new({'name' => 'Cooking Shrimp', 'course_number' => 'CK306'})
    expect(test_course.name).to eq 'Cooking Shrimp'
    expect(test_course.course_number).to eq 'CK306'
  end

  it 'will start out with an empty array' do
    expect(Course.all).to eq []
  end

  it 'will save a new course to the database' do
    test_course = Course.new({'name' => 'Cooking Shrimp', 'course_number' => 'CK306'})
    test_course.save
    expect(Course.all).to eq [test_course]
  end

  it 'will be the same course if it has the same name and course number' do
    test_course = Course.new({'name' => 'Cooking Shrimp', 'course_number' => 'CK306'})
    test_course.save
    test_course1 = Course.new({'name' => 'Cooking Shrimp', 'course_number' => 'CK306'})
    test_course1.save
    expect(test_course1).to eq test_course
  end

  it 'will update a courses name' do
    test_course = Course.new({'name' => 'Cooking Strimp', 'course_number' => 'CK306'})
    test_course.save
    test_course.update_name('Cooking Shrimp')
    expect(test_course.name).to eq 'Cooking Shrimp'
  end

  it 'will update a courses course number' do
    test_course = Course.new({'name' => 'Cooking Shrimp', 'course_number' => 'CK305'})
    test_course.save
    test_course.update_number('CK306')
    expect(test_course.course_number).to eq 'CK306'
  end

  it 'will delete a course from the database' do
    test_course = Course.new({'name' => 'Cooking Shrimp', 'course_number' => 'CK306'})
    test_course.save
    test_course.delete
    expect(Course.all).to eq []
  end

  it 'will add a student to the course' do
    test_course = Course.new({'name' => 'Cooking Shrimp', 'course_number' => 'CK306'})
    test_course.save
    test_student = Student.new({'name' => 'Forrest Gump', 'student_number' => 1345})
    test_student.save
    test_course.add_student(test_student)
    expect(test_course.students).to eq [test_student]
  end

  it 'will delete a student from the course' do
    test_course = Course.new({'name' => 'Cooking Shrimp', 'course_number' => 'CK306'})
    test_course.save
    test_student = Student.new({'name' => 'Forrest Gump', 'student_number' => 1345})
    test_student.save
    test_course.add_student(test_student)
    test_course.delete_student(test_student)
    expect(test_course.students).to eq []
  end
end
