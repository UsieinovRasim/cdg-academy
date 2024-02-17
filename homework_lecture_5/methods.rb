def index(file_name)
  File.open(file_name).each do |line|
    puts "#{line} "
  end
end

def find(file_name, id)
  lines = File.readlines(file_name)
  line = lines[id - 1]
  puts "#{id}: #{line}" if line
end

def where(file_name, pattern)
  lines = File.readlines(file_name)
  lines.each_with_index do |line, index|
    puts "#{index + 1}: #{line}" if line.include?(pattern)
  end
end

def update(file_name, id, text)
  lines = File.readlines(file_name)
  lines[id - 1] = "#{text}\n"
  File.open(file_name, 'w') { |file| file.puts lines }
end

def delete(file_name, id)
  lines = File.readlines(file_name)
  lines.delete_at(id - 1)
  File.open(file_name, 'w') { |file| file.puts lines }
end

def create(file_name, name)
  File.open(file_name, 'a') { |file| file.puts "#{name}\n" }
end

index('example.txt')
find('example.txt', 1)
where('example.txt', 'pattern')
update('example.txt', 2, 'Updated Line')
delete('example.txt', 3)
create('example.txt', 'New line')
