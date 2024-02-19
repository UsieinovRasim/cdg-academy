require 'rspec'
require 'rack/test'
require_relative '../app'

RSpec.describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET /deposit' do
    it 'возвращает сообщение об успешном депозите' do
      get '/deposit', value: 50
      expect(last_response).to be_ok
      expect(last_response.body).to include('Депозит средств успешен')
    end

    it 'возвращает сообщение о неверной сумме депозита' do
      get '/deposit', value: -50
      expect(last_response).to be_ok
      expect(last_response.body).to include('Неверная сумма депозита')
    end
  end

  describe 'GET /withdraw' do
    it 'возвращает сообщение об успешном выводе' do
      get '/withdraw', value: 30
      expect(last_response).to be_ok
      expect(last_response.body).to include('Вывод средств успешен')
    end

    it 'возвращает сообщение о недостаточных средствах для вывода' do
      get '/withdraw', value: 150
      expect(last_response).to be_ok
      expect(last_response.body).to include('Недостаточно средств для вывода')
    end

    it 'возвращает сообщение о неверной сумме для вывода' do
      get '/withdraw', value: -30
      expect(last_response).to be_ok
      expect(last_response.body).to include('Неверная сумма для вывода')
    end
  end

  describe 'GET /balance' do
    it 'возвращает текущий баланс' do
      get '/balance'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Текущий баланс')
    end
  end
end
