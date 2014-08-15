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



end
