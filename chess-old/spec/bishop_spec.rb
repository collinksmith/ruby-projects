require_relative 'spec_helper'

describe Bishop do
  before :each do
    @board = Board.new
    @bishop = Bishop.new([4,4], @board, :white)
  end

  describe ".check_move" do
    it "can move diagonally from bottom left to top right" do
      expect(@bishop.check_move([7,7])).to eq(true)
    end

    it "can move digaonally from top left to bottom right" do
      expect(@bishop.check_move([5,3])).to eq(true)
    end

    it "cannot move along a column" do
      expect { @bishop.check_move([4,1]) }.to raise_error(ArgumentError)
    end

    it "cannot move along a row" do
      expect { @bishop.check_move([7,4]) }.to raise_error(ArgumentError)
    end
  end

end