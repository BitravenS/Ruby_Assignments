require './lib/calculator'

RSpec.describe Calculator do
  describe '#add' do
    it 'returns the sum of two numbers' do
      calculator = Calculator.new
      expect(calculator.add(2, 3)).to eq(5)
    end
  end

  describe '#subtract' do
    it 'returns the difference of two numbers' do
      calculator = Calculator.new
      expect(calculator.subtract(5, 3)).to eq(2)
    end
  end

  describe '#multiply' do
    it 'returns the product of two numbers' do
      calculator = Calculator.new
      expect(calculator.multiply(2, 3)).to eq(6)
    end
  end
end
