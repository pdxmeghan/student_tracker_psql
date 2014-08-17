####Student and Course Tracker
#####written by Meghan Lindsley for Ruby Database Basics Assessment

######
This program allows a user to track courses and students within a database system.


#####TO USE:
######To use this program, you'll need to set up a psql database. You can use these commands to do so:

CREATE DATABASE student_tracker;
CREATE TABLE students (id serial PRIMARY KEY, name varchar, student_number numeric)
CREATE TABLE courses (id serial PRIMARY KEY, name varchar, course_number varchar)
CREATE TABLE courses_students (id serial PRIMARY KEY, course_id int, student_id int)

You will also need to use the pg gem.

#####Known Issues:
######You can only add students to a course. You cannot add a course to a student.
You must enter the full name of a student or course NOT including the student or course number in order to select either one.

MIT License. Copyright Meghan Lindsley 2014
