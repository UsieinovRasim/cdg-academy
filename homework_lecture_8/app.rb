require 'sinatra'

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

get '/deposit' do
  amount = params['value'].to_f
  balance = read_balance

  if amount.positive?
    balance += amount
    write_balance(balance)
    "Депозит средств успешен. Новый баланс: #{balance}"
  else
    'Неверная сумма депозита. Пожалуйста, введите положительную сумму.'
  end
end

get '/withdraw' do
  amount = params['value'].to_f
  balance = read_balance

  if amount.positive? && amount <= balance
    balance -= amount
    write_balance(balance)
    "Вывод средств успешен. Новый баланс: #{balance}"
  elsif amount <= 0
    'Неверная сумма для вывода. Пожалуйста, введите положительную сумму.'
  else
    'Недостаточно средств для вывода. Пожалуйста, введите действительную сумму.'
  end
end

get '/balance' do
  balance = read_balance
  "Текущий баланс: #{balance}"
end
