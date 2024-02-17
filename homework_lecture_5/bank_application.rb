BALANCE_FILE = 'balance.txt'.freeze
STARTING_BALANCE = 100.0

def read_balance
  if File.exist?(BALANCE_FILE)
    File.read(BALANCE_FILE).to_f
  else
    STARTING_BALANCE
  end
end

def write_balance(balance)
  File.write(BALANCE_FILE, balance.to_s)
end

def deposit(balance, amount)
  if amount.positive?
    balance += amount
    puts "Депозит средств успешен. Новый баланс: #{balance}"
  else
    puts 'Неверная сумма депозита. Пожалуйста, введите положительную сумму.'
  end
  balance
end

def withdraw(balance, amount)
  if amount.positive? && amount <= balance
    balance -= amount
    puts "Вывод средств успешен. Новый баланс: #{balance}"
  elsif amount <= 0
    puts 'Неверная сумма для вывода. Пожалуйста, введите положительную сумму.'
  else
    puts 'Недостаточно средств для вывода. Пожалуйста, введите действительную сумму.'
  end
  balance
end

def display_balance(balance)
  puts "Текущий баланс: #{balance}"
end

def input_amount(prompt)
  puts prompt
  loop do
    amount = gets.chomp.to_f
    return amount if amount.positive?

    puts 'Неверная сумма. Пожалуйста, введите положительное число.'
  end
end

def main_menu_prompt
  "\nВыберите опцию: D (Депозит), W (Вывод), B (Баланс), Q (Выйти)"
end

def main_menu(_balance)
  puts main_menu_prompt
  gets.chomp.upcase
end

def main
  balance = read_balance

  loop do
    choice = main_menu(balance)

    case choice
    when 'D'
      amount = input_amount('Введите сумму депозита:')
      balance = deposit(balance, amount)
    when 'W'
      amount = input_amount('Введите сумму вывода:')
      balance = withdraw(balance, amount)
    when 'B'
      display_balance(balance)
    when 'Q'
      write_balance(balance)
      puts "Выход из программы. Окончательный баланс: #{balance}"
      break
    else
      puts 'Неверный выбор. Пожалуйста, введите D, W, B, или Q.'
    end
  end
end

main
