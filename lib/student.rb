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

  def ==(another_student)
    @name == another_student.name && @student_number == another_student.student_number
  end
end
