@students = [] # An empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  # Get the first name
  name = STDIN.gets.chomp
  # While the name is not empty, repeat this code
  while !name.empty? do
    # Add the sutdent hash to the array
    @students << { name: name, cohort: :november }
    puts "Now we have #{@students.count} students"
    # Get another name from the user
    name = STDIN.gets.chomp
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def load_students_from_commandline
  filename = ARGV.first # First argument from the command line
  filename = "students.csv" if filename.nil? # Get out of the method if it isn't given
  if File.exist?(filename) # If it exists
    load_students(filename)
    puts "Loaded #{@students.count} #{@students.count == 1 ? "student" : "students"} from #{filename}"
  else # If it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # Quit the program
  end
end

def print_menu
  puts "\n1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "9. Exit" # 9 because we'll be adding more items
end

def print_directory
  print_header
  print_students_list
  print_footer
end

def process(selection)
  puts ""
  case selection
    when "1"
      input_students
    when "2"
      print_directory
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # This will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def get_filename(check_if_exists: true)
  puts "Please input the file you wish to perform this action on"
  filename = gets.chomp
  while check_if_exists && !File.exists?(filename)
    puts "The file #{filename} doesn't exist. Please input the file name again"
    filename = STDIN.gets.chomp
  end
  filename
end

def save_students
  filename = get_filename(check_if_exists: false)
  # Open the file for writing
  File.open(filename, "w") do |file|
    # Iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
  puts "Succesfully saved students to #{filename}"
end

def load_students(filename=nil)
  filename ||= get_filename
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      @students << { name: name, cohort: cohort.to_sym }
    end
  end
  puts "Successfully loaded students from #{filename}"
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

load_students_from_commandline
interactive_menu
