require '../lib/caesar-cipher.rb'

describe 'caesar-cipher' do
  it 'shifts letters correctly with a positive shift' do
    expect(caesar_cipher('abc', 3)).to eql('def')
  end

  it 'shifts letters correctly with a negative shift' do
    expect(caesar_cipher('def', -3)).to eql('abc')
  end

  it 'maintains case of letters' do
    expect(caesar_cipher('AbC', 3)).to eql('DeF')
  end

  it 'handles wrap around from z to a' do
    expect(caesar_cipher('xyz', 3)).to eql('abc')
  end

  it 'does not alter non-alphabetic characters' do
    expect(caesar_cipher('abc! 123', 3)).to eql('def! 123')
  end

  it 'handles wrap around when shift amount is above 26' do
    expect(caesar_cipher('abc! 123', 29)).to eql('def! 123')
  end
end