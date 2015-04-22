class Student
  attr_reader :first_name, :last_name, :courses

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = Array.new
  end

  def name
    "#{first_name} #{last_name}"
  end

  def enroll(course)
    unless courses.include? course
      courses << course
    end
    unless course.students.include? self
      course.add_student(self)
    end
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
    @students = Array.new
  end

  def add_student(student)
    unless students.include?(student)
      students << student
    end
    unless student.courses.include?(self)
      student.enroll(self)
    end
  end

  def to_s
    @name
  end
end
