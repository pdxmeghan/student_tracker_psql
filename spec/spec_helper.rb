require 'rspec'
require 'course'
require 'student'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'student_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM students * ;")
    DB.exec("DELETE FROM courses * ;")
  end
end
