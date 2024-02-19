def number_of_pokemon
  input = 0
  while input <= 0
    puts 'Сколько добавить покемонов?'
    input = gets.chomp.to_i
    puts 'Введите число больше 0' if input <= 0
  end
  input
end

def pokemon(index)
  puts "Введите имя покемона №#{index}:"
  name = gets.chomp

  puts "Введите цвет покемона №#{index}:"
  color = gets.chomp

  { name:, color: }
end

def display_pokemon_arr(number_of_pokemon)
  pokemons = []
  1.upto(number_of_pokemon) { |i| pokemons << pokemon(i) }
  puts "Массив покемонов:\n #{pokemons}"
end

display_pokemon_arr(number_of_pokemon)
