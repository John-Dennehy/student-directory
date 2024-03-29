# Variables
@students = []

# Methods
def print_menu
  puts ""
  puts "==Menu==============================="
  puts "  1. Input the students"
  puts "  2. Show the students"
  puts "  3. Save the list to students.csv"
  puts "  4. Load students.csv"
  puts "  ----"
  puts "  9. Exit"
  puts "====================================="
end

def show_students
  print_header
  print
  print_footer
end

def interactive_menu
  loop do
    print_menu
    selection = STDIN.gets.chomp
    case selection
    when "1"
      # input the students
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # terminate the program
    else
      puts "That is not one of the options. Please select again."
    end
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  # get the first name
  name = STDIN.gets.chomp

  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"

    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------------------------"
end

def print
  # print all the names of sudents passed to method
  @students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort].capitalize} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end 

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil?
  if File.exists?(filename) # check if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end
end

# Method Calls
try_load_students
interactive_menu