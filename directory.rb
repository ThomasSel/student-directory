# Array containing all valid cohorts
@cohorts = [:january, :february, :march, :april, :may, :june, :july, 
           :august, :september, :october, :november, :december]

def input_students
  puts "Please enter the names, and cohort of the students"
  puts "To finish, just hit return twice"

  # Create an empty array
  students = []
  while true do
    # Get a name from the user
    print "NAME: "
    name = gets.chomp
    break if name.empty?

    # Get the cohort from the user
    while true do
      print "Cohort: "
      cohort = gets.chomp.downcase
      cohort = :november if cohort.empty?
      break if @cohorts.include?(cohort.to_sym) 
      puts "Not a valid cohort, please re-enter the cohort"
    end
    # Add the sutdent hash to the array
    students << { name: name, cohort: cohort.to_sym }
    puts "Now we have #{students.count} #{students.count == 1 ? "student" : "students"}"
  end
  # Return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------"
end

def print_students(students)
  unless students.count == 0
    students.sort_by! { |student| @cohorts.index(student[:cohort]) }
    students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

# Nothing happens until we call the methods
students = input_students
print_header
print_students(students)
print_footer(students)
