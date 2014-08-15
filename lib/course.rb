class Course
  attr_reader :name, :course_number, :id

  def initialize(attributes)
    @name = attributes['name']
    @course_number = attributes['course_number']
    @id = attributes['id'].to_i
  end
end
