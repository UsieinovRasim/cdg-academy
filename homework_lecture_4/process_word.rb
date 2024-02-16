def process_word(word)
  result = if word.upcase.end_with?('CS')
             2**word.length
           else
             word.reverse
           end
  puts result
end

print 'Введите слово: '
user_input = gets.chomp

process_word(user_input)
