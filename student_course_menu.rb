require './lib/course'
require './lib/student'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'student_tracker'})

def main_menu
  loop do
    puts "Press 'ac' to add a course"
    puts "Press 'as' to add a student"
    puts "Press 'vc' to view a course record"
    puts "Press 'vs' to view a student record"
    puts "Press 'x' to exit the program"
    menu_choice = gets.chomp
    if menu_choice == 'ac'
      add_course
    elsif menu_choice == 'as'
      add_student
    elsif menu_choice == 'vc'
      view_course
    elsif menu_choice == 'vs'
      view_student
    elsif menu_choice == 'x'
      puts "Goodbye!"
      exit
    else
      puts "Sorry! Please input a valid option."
    end
  end
end

def add_course
  puts "\nWhat is the name of the course you would like to add?"
  course_name = gets.chomp
  puts "\nWhat is the course number of the course you would like to add?"
  course_number = gets.chomp
  added_course = Course.new({'name' => course_name, 'course_number' => course_number})
  added_course.save
  puts "\nThanks! [#{added_course.name} - #{added_course.course_number}] has been added to the list of courses.\n"
end

def add_student
  puts "\nWhat is the name of the student you would like to add?"
  student_name = gets.chomp
  puts "\nWhat is the student number of the student you would like to add?"
  student_number = gets.chomp
  added_student = Student.new({'name' => student_name, 'student_number' => student_number})
  added_student.save
  puts "\nThanks! [#{added_student.name} - #{added_student.student_number}] has been added to the list of students.\n"
end

def view_course
  puts "\nAll courses:"
  Course.all.each do |course|
    name = course.name
    number = course.course_number
    puts "#{name} - #{number}"
  end
  puts "\nPlease enter the name of the course you would like to view"
  course_choice = gets.chomp
  Course.all.each do |course|
    name = course.name
    number = course.course_number
    if name == course_choice
      @selected_course = course
    end
  end
  puts "You have chosen #{@selected_course.name} -- #{@selected_course.course_number}"
  # puts "\nAll students currently enrolled in #{@selected_course.name}:"
  # @selected_course.students.each do |student|
  #   puts "\n{student.name} -- #{student.student_number}"
  # end
  course_menu
end

def view_student
  puts "\nAll students:"
  Student.all.each do |student|
    name = student.name
    number = student.student_number
    puts "#{name} -- #{number}"
  end
  puts "\nPlease enter the name of the student you would like to view"
  student_choice = gets.chomp
  Student.all.each do |student|
    name = student.name
    number = student.student_number
    if name == student_choice
      @selected_student = student
    end
  end
  puts "\nYou have chosen #{@selected_student.name} -- #{@selected_student.student_number}\n"
  # puts "All classes #{@selected_student.name} is currently enrolled in:"
  # @selected_student.list_courses.each do |course|
  #   puts "\n#{course.name} -- #{course.course_number}"
  # end
  student_menu
end

def course_menu
  loop do
    puts "Press 'as' to add a student to this course"
    puts "Press 'u' to update this course's information"
    puts "Press 'd' to delete this course"
    puts "Press 'l' to list out all students currently enrolled in this course."
    puts "Press 'm' to go to the main menu"
    puts "Press 'x' to exit the program"
    menu_choice = gets.chomp
    if menu_choice == 'as'
      add_student_to_course
    elsif menu_choice == 'u'
      update_course
    elsif menu_choice == 'd'
      delete_course
    elsif menu_choice == 'l'
      list_students_in_course
    elsif menu_choice == 'm'
      main_menu
    elsif menu_choice == 'x'
      puts "Goodbye!"
      exit
    end
  end
end

def add_student_to_course
  Student.all.each do |student|
    name = student.name
    number = student.student_number
    puts "\n#{name} -- #{number}"
  end
  puts "Input the name of the student you would like to add to the course"
  student_choice = gets.chomp
  Student.all.each do |student|
    if student_choice == student.name
      @name = student.name
      @selected_course.add_student(student)
    end
  end
  puts "\nThanks! #{@name} has been added to #{@selected_course.name} -- #{@selected_course.course_number}.\n"
end

def update_course
  puts "\nWhat is the new course name?"
  new_name = gets.chomp
  puts "\nWhat is the new course number?"
  new_number = gets.chomp
  @selected_course.update_name(new_name)
  @selected_course.update_number(new_number)
  puts "\nThanks! This entry is now: #{@selected_course.name} -##{#### NOT WORKING}}- #{@selected_course.course_number}\n"
end

def list_students_in_course
  puts "\nAll students currently enrolled in #{@selected_course.name}:"
  @selected_course.students.each do |student|
    puts "\n#{student.name} -- #{student.student_number}\n"
  end
end
main_menu
