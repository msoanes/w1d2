class Student
  attr_reader :first_name, :last_name, :courses

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    "#{first_name} #{last_name}"
  end

  def enroll(course)
    courses << course unless courses.include? course
    course.add_student(self) unless course.students.include? self
  end

  def course_load
    results = Hash.new(0)
    courses.each do |course|
      results[course.department] += course.credits
    end
    results
  end

  def to_s
    name
  end
end

class Course
  attr_reader :students, :department, :credits, :name

  def initialize(name, department, credits)
    @name = name
    @department = department
    @credits = credits
    @students = []
  end

  def add_student(student)
    students << student unless students.include?(student)
    student.enroll(self) unless student.courses.include?(self)
  end

  def to_s
    @name
  end
end
