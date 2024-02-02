require 'rspec'
require_relative '../foobar'

RSpec.describe '#foobar' do
  it 'возвращает второе число, если хотя бы одно из чисел равно 20' do
    expect(foobar(20, 325)).to eq 325
    expect(foobar(15, 20)).to eq 20
    expect(foobar(20.0, 325)).to eq 325
    expect(foobar(15.5, 20)).to eq 20
    expect(foobar('20', 325)).to eq 325
    expect(foobar(15, '20')).to eq 20
  end

  it 'возвращает сумму чисел, если ни одно из чисел не равно 20' do
    expect(foobar(5, 72)).to eq 77
    expect(foobar(0, 0)).to eq 0
    expect(foobar(5.25, 72)).to eq 77.25
    expect(foobar(0.0, 0)).to eq 0
    expect(foobar('5', '72')).to eq 77
    expect(foobar('0', '0')).to eq 0
  end

  it 'возвращает второе отрицательное число, если хотя бы одно из чисел равно 20' do
    expect(foobar(20, -325)).to eq -325
    expect(foobar(-15, 20)).to eq 20
  end

  it 'возвращает сумму отрицательных чисел, если ни одно из чисел не равно 20' do
    expect(foobar(-5, -72)).to eq -77
    expect(foobar(-20, 20)).to eq 20
  end
end
