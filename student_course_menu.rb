require './lib/course'
require './lib/student'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'student_tracker'})

def main_menu
  loop do
    puts "\nPress 'ac' to add a course to the database"
    puts "Press 'as' to add a student to the database"
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
  if Course.all.empty?
    puts "Sorry! There are no courses. Please add courses.\n"
    main_menu
  else
    Course.all.each do |course|
      name = course.name
      number = course.course_number
      puts "[#{name} - #{number}]"
    end
  end
  puts "\nPlease enter the name of the course you would like to view\n"
  course_choice = gets.chomp
  Course.all.each do |course|
    name = course.name
    number = course.course_number
    if name == course_choice
      @selected_course = course
      puts "\nYou have chosen [#{@selected_course.name} -- #{@selected_course.course_number}]\n"
      break
    else
      puts "\nPlease enter a valid option.\n"
      main_menu
    end
  end
  course_menu
end

def view_student
  puts "\nAll students:"
  if Student.all.empty?
    puts "Sorry! There are no students. Please add students: \n"
    main_menu
  else
    Student.all.each do |student|
      name = student.name
      number = student.student_number
      puts "[#{name} -- #{number}]"
    end
  end
  puts "\nPlease enter the name of the student you would like to view"
  student_choice = gets.chomp
  Student.all.each do |student|
    name = student.name
    number = student.student_number
    if name == student_choice
      @selected_student = student
    else
      puts "\nPlease input a valid student name"
      main_menu
    end
  end
  puts "\nYou have chosen [#{@selected_student.name} -- #{@selected_student.student_number}]\n"
  student_menu
end

def course_menu
  loop do
    puts "\nPress 'as' to add a student to this course"
    puts "Press 'u' to update this course's information"
    puts "Press 'd' to delete this course"
    puts "Press 'l' to list out all students currently enrolled in this course."
    puts "Press 'ds' to delete a student from this course"
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
    elsif menu_choice == 'ds'
      delete_student_from_course
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
    puts "\n[#{name} -- #{number}]"
  end
  puts "Input the name of the student you would like to add to the course"
  student_choice = gets.chomp
  Student.all.each do |student|
    if student_choice == student.name
      @name = student.name
      @selected_course.add_student(student)
    else
      puts "\nPlease input a valid student name"
      main_menu
    end
  end
  puts "\nThanks! [#{@name}] has been added to [#{@selected_course.name} -- #{@selected_course.course_number}].\n"
end

def delete_student_from_course
  if @selected_course.students.empty?
    puts "\nThere are no students enrolled in this course\n"
    main_menu
  else
    @selected_course.students.each do |student|
      name = student.name
      number  = student.student_number
      puts "[#{name} -- #{number}"
    end
  end
  puts "\nEnter the name of the student you would like to delete from this course\n"
  student_choice = gets.chomp
  @selected_course.students.each do |student|
    if student_choice == student.name
      @selected_course.delete_student(student)
    else
      puts "\nPlease input a valid student name"
      course_menu
    end
  end
  puts "Thanks! This student has been deleted from [#{@selected_course.name} -- #{@selected_course.course_number}].\n"
end

def update_course
  puts "\nWhat is the new course name?"
  new_name = gets.chomp
  puts "\nWhat is the new course number?"
  new_number = gets.chomp
  name = @selected_course.update_name(new_name)
  course_number = @selected_course.update_number(new_number)
  puts "\nThanks! This entry is now: [#{name} -- #{course_number}]\n"
end

def delete_course
  puts "Would you like to permanently delete #{@selected_course.name} -- #{@selected_course.course_number}?"
  puts "Enter 'y' for Yes or 'n' for No"
  menu_choice = gets.chomp
  if menu_choice == 'y' || menu_choice == 'Y'
    @selected_course.delete
    puts "[#{@selected_course.name} -- #{@selected_course.course_number}] has been deleted.\n"
  elsif menu_choice == 'n' || menu_choice == 'N'
    puts "\n[#{@selected_course.name} -- #{@selected_course.course_number}] has not been deleted\n"
  else
    puts "Please enter a valid option."
    course_menu
  end
end

def list_students_in_course
  if @selected_course.students.empty?
    puts "\nThere are no students in this course. You can add students here:"
    course_menu
  else
    puts "\nAll students currently enrolled in #{@selected_course.name}:"
    @selected_course.students.each do |student|
      puts "\n[#{student.name} -- #{student.student_number}]\n"
    end
  end
end

def student_menu
  loop do
    puts "\nPress 'u' to update this student's record"
    puts "Press 'd' to delete this student's record"
    puts "Press 'l' to list out of this student's courses"
    puts "Press 'm' to go to the main menu"
    puts "Press 'x' to exit the program"
    menu_choice = gets.chomp
    if menu_choice == 'u'
      update_student
    elsif menu_choice == 'd'
      delete_student
    elsif menu_choice == 'l'
      list_courses_for_student
    elsif menu_choice == 'm'
      main_menu
    elsif menu_choice == 'x'
      puts "Goodbye!"
      exit
    else
      puts "Please input valid option"
    end
  end
end

def update_student
  puts "\nWhat is student's new name?"
  name_choice = gets.chomp
  puts "\nWhat is the student's new student number?"
  number_choice = gets.chomp
  @selected_student.update_name(name_choice)
  @selected_student.update_number(number_choice)
  puts "\nThanks! This student is now recorded as [#{name_choice} -- #{number_choice}]\n"
end

def delete_student
  puts "\nAre you sure you want to permanently delete [#{@selected_student.name} -- #{@selected_student.student_number}]?"
  puts "\nPress 'y' for Yes or 'n' for No."
  menu_choice = gets.chomp
  if menu_choice == 'y' || menu_choice ==  'Y'
    @selected_student.delete_student
    puts "[#{@selected_student.name} -- #{@selected_student.student_number}] has been deleted.\n"
  elsif menu_choice == 'n' || menu_choice == 'N'
    puts "\n[#{@selected_student.name} -- #{@selected_student.student_number}] has not been deleted\n"
  else
    puts "Please enter a valid option."
    course_menu
  end
end

def list_courses_for_student
  if @selected_student.list_courses.empty?
    puts "\nThis student is not enrolled in any courses.\n"
  else
    puts "\n[#{@selected_student.name} -- #{@selected_student.student_number}] is currently enrolled in these courses:\n"
    @selected_student.list_courses.each do |course|
      course_name = course.name
      course_number = course.course_number
      puts "[#{course_name} -- #{course_number}]"
    end
  end
end

main_menu
