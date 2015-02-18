require_relative 'spec_helper'

describe 'my_inject' do
  
  let(:a) { [2,3,4] }

  context 'when given no parameters' do
    it 'adds correctly' do
      expect(a.my_inject { |t, i| t+i }).to eq(9)
    end

    it 'subtracts correctly' do
      expect(a.my_inject { |t, i| t-i }).to eq(-5)
    end

    it 'multiplies correctly' do
      expect(a.my_inject { |t, i| t*i }).to eq(24)
    end

    it 'divides correctly' do
      b = [20, 2, 2]
      expect(b.my_inject { |t, i| t.to_f/i.to_f }).to eq(5)
    end

    it 'inserts strings' do
      expect(a.my_inject { |t, i| "#{t} #{i} string!" }).to eq('2 3 string! 4 string!')
    end
  end

  context 'when given a parameter' do
    it 'adds correctly' do
      expect(a.my_inject(5) { |t, i| t+i }).to eq(14)
    end

    it 'subtracts correctly' do
      expect(a.my_inject(5) { |t, i| t-i }).to eq(-4)
    end

    it 'multiplies correctly' do
      expect(a.my_inject(5) { |t, i| t*i }).to eq(120)
    end

    it 'returns zero when multiplying with a parameter of zero' do
      expect(a.my_inject(0) { |t, i| t*i }).to eq(0)
    end

    it 'divides correctly' do
      b = [2, 2, 2]
      expect(b.my_inject(40) { |t, i| t.to_f/i.to_f }).to eq(5)
    end
  end
end