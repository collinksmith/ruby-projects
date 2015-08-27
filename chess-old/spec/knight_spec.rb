require_relative 'spec_helper'

describe Knight do
  before :each do
    @board = Board.new
    @knight = Knight.new([4,4], @board, :white)
  end

  describe ".check_move" do
    it "can make all it's correct moves" do
      expect(@knight.check_move([6,5])).to eq(true)
      expect(@knight.check_move([6,3])).to eq(true)
      expect(@knight.check_move([5,6])).to eq(true)
      expect(@knight.check_move([5,2])).to eq(true)
      expect(@knight.check_move([3,6])).to eq(true)
      expect(@knight.check_move([3,2])).to eq(true)
      expect(@knight.check_move([2,5])).to eq(true)
      expect(@knight.check_move([2,3])).to eq(true)
    end

    it "cannot move along a column" do
      expect { @knight.check_move([6,4]) }.to raise_error(ArgumentError)
    end

    it "cannot move along a row" do
      expect { @knight.check_move([4,6]) }.to raise_error(ArgumentError)
    end

    it "cannot move diagonally" do
      expect { @knight.check_move([5,5]) }.to raise_error(ArgumentError)
    end
  end
end