def greeting
  puts 'Введите Ваше имя:'
  name = gets.chomp.capitalize
  return puts 'Имя не может быть пустым!' if name == ''

  puts 'Введите Вашу фамилию:'
  surname = gets.chomp.capitalize
  return puts 'Фамилия не может быть пустой!' if surname == ''

  puts 'Введите Ваш возраст:'
  age = gets.chomp.to_i
  return puts "Возрост не может быть равен #{age}" if age <= 0

  if age < 18
    puts "Привет, #{name} #{surname}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано"
  else
    puts "Привет, #{name} #{surname}. Самое время заняться делом!"
  end
end

greeting
