class Course
  attr_reader :name, :course_number, :id

  def initialize(attributes)
    @name = attributes['name']
    @course_number = attributes['course_number']
    @id = attributes['id'].to_i
  end

  def self.all
    courses = []
    results = DB.exec("SELECT * FROM courses;")
    results.each do |result|
      courses << Course.new(result)
    end
    courses
  end

  def save
    results = DB.exec("INSERT INTO courses (name, course_number) VALUES ('#{@name}', '#{@course_number}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def update_name(new_name)
    DB.exec("UPDATE courses SET name = '#{new_name}' WHERE id = #{@id};")
    results = DB.exec("SELECT * FROM courses;")
    @name = results.first['name']
  end

  def update_number(new_number)
    DB.exec("UPDATE courses SET course_number = '#{new_number}' WHERE id = #{@id};")
    results = DB.exec("SELECT * FROM courses;")
    @course_number = results.first['course_number']
  end

  def ==(another_course)
    @name == another_course.name && @course_number == another_course.course_number
  end
end
