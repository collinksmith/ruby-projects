require_relative 'spec_helper'

describe Rook do
  before :each do
    @board = Board.new
    @rook = Rook.new([4,4], @board, :white)
  end

  context ".check_move" do
    it "can move along a column" do
      expect(@rook.check_move([4,7])).to eq(true)
    end

    it "can move along a row" do
      expect(@rook.check_move([3,4])).to eq(true)
    end

    it "cannot move diagonally" do
      expect { @rook.check_move([5,5]) }.to raise_error(ArgumentError)
    end

  end
end