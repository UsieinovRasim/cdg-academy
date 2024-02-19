def find_students_by_age(file_path, age)
  students = []

  File.foreach(file_path) do |line|
    name, surname, student_age = line.split
    students << "#{name} #{surname} #{student_age}" if student_age.to_i == age
  end

  students
end

def write_students_to_file(file_path, students)
  File.open(file_path, 'a') do |file|
    students.each { |student| file.puts(student) }
  end
end

def main
  input_file = 'students.txt'
  output_file = 'results.txt'

  loop do
    puts 'Введите возраст студента (для выхода введите -1):'
    user_input = gets.chomp.to_i

    break if user_input == -1

    matching_students = find_students_by_age(input_file, user_input)
    write_students_to_file(output_file, matching_students)
  end

  puts "Содержимое файла #{output_file}:"
  puts File.read(output_file)
end

main
