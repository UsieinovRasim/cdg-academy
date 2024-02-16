require 'rspec'
require_relative '../process_word'

RSpec.describe '#process_word' do
  it 'возвращает 2 в степени длины слова, если слово заканчивается на "CS"(в любом регистре)' do
    expect { process_word('wordCS') }.to output("64\n").to_stdout
    expect { process_word('Pointcs') }.to output("128\n").to_stdout
    expect { process_word('schoolCs') }.to output("256\n").to_stdout
    expect { process_word('anoThercS') }.to output("512\n").to_stdout
  end

  it 'возвращает слово задом наперед, если слово не заканчивается на "CS"' do
    expect { process_word('Ruby') }.to output("ybuR\n").to_stdout
    expect { process_word('python') }.to output("nohtyp\n").to_stdout
  end
end
