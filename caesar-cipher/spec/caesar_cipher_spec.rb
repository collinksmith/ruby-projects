require_relative 'spec_helper'

describe 'casear_cipher' do
  it 'translates lowercase letters' do
    expect(caesar_cipher('a', 1)).to eq('b')
  end

  it 'translates uppercase letters' do
    expect(caesar_cipher('A', 1)).to eq('B')
  end

  it 'wraps lowercase letters from z to a' do
    expect(caesar_cipher('z', 1)).to eq('a')
  end

  it 'wraps uppercase letters from Z to A' do
    expect(caesar_cipher('Z', 1)).to eq('A')
  end

  it "doesn't change special characters" do
    expect(caesar_cipher('#$%_-., ', 1)).to eq('#$%_-., ')
  end

  it 'accepts translations of 0' do
    expect(caesar_cipher('hello', 0)).to eq('hello')
  end

  it 'accepts translations of 26' do
    expect(caesar_cipher('hello', 0)).to eq('hello')
  end

  it 'accurately translates a sentence' do
    expect(caesar_cipher('What is your name?', 5)).to eq('Bmfy nx dtzw sfrj?')
  end
end