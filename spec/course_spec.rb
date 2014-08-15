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


end
