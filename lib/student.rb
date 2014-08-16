class Student
  attr_reader :name, :student_number, :id

  def initialize(attributes)
    @name = attributes['name']
    @student_number = attributes['student_number'].to_i
    @id = attributes['id'].to_i
  end

  def self.all
    students = []
    results = DB.exec("SELECT * FROM students;")
    results.each do |result|
      students << Student.new(result)
    end
    students
  end

  def save
    results = DB.exec("INSERT INTO students (name, student_number) VALUES ('#{@name}', #{student_number}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def update_name(new_name)
    DB.exec("UPDATE students SET name = '#{new_name}' WHERE id = #{@id};")
    results = DB.exec("SELECT * from students WHERE id = #{@id};")
    @name = results.first['name']
  end

  def update_number(new_number)
    DB.exec("UPDATE students SET student_number = #{new_number} WHERE id = #{@id};")
    results = DB.exec("SELECT * FROM students WHERE id = #{@id};")
    @student_number = results.first['student_number'].to_i
  end

  def delete_student
    DB.exec("DELETE FROM students WHERE id = #{@id};")
  end

  def list_courses
    courses = []
    results = DB.exec("SELECT courses.* FROM students
              JOIN courses_students on (students.id = courses_students.student_id)
              JOIN courses on (courses_students.course_id = courses.id)
              WHERE students.id = #{@id};")
    results.each do |result|
      courses << Course.new(result)
    end
    courses
  end

  def ==(another_student)
    @name == another_student.name && @student_number == another_student.student_number
  end
end
