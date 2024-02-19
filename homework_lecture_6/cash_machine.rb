# frozen_string_literal: true

# Класс CashMachine представляет банкомат с базовыми операциями:
# депозит, вывод, проверка баланса и выход из программы.
class CashMachine
  BALANCE_FILE = 'balance.txt'
  STARTING_BALANCE = 100.0

  attr_reader :balance

  def initialize
    @balance = read_balance
  end

  def self.init
    new.start
  end

  def deposit(amount)
    if amount.positive?
      @balance += amount
      puts "Депозит средств успешен. Новый баланс: #{@balance}"
    else
      puts 'Неверная сумма депозита. Пожалуйста, введите положительную сумму.'
    end
  end

  def withdraw(amount)
    if amount.positive? && amount <= @balance
      @balance -= amount
      puts "Вывод средств успешен. Новый баланс: #{@balance}"
    elsif amount <= 0
      puts 'Неверная сумма для вывода. Пожалуйста, введите положительную сумму.'
    else
      puts 'Недостаточно средств для вывода. Пожалуйста, введите действительную сумму.'
    end
  end

  def display_balance
    puts "Текущий баланс: #{@balance}"
  end

  def start
    loop do
      choice = main_menu

      case choice
      when 'D'
        amount = input_amount('Введите сумму депозита:')
        deposit(amount)
      when 'W'
        amount = input_amount('Введите сумму вывода:')
        withdraw(amount)
      when 'B'
        display_balance
      when 'Q'
        write_balance
        puts "Выход из программы. Окончательный баланс: #{@balance}"
        break
      else
        puts 'Неверный выбор. Пожалуйста, введите D, W, B, или Q.'
      end
    end
  end

  private

  def read_balance
    if File.exist?(BALANCE_FILE)
      File.read(BALANCE_FILE).to_f
    else
      STARTING_BALANCE
    end
  end

  def write_balance
    File.write(BALANCE_FILE, @balance.to_s)
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

  def main_menu
    puts main_menu_prompt
    gets.chomp.upcase
  end
end

CashMachine.init
