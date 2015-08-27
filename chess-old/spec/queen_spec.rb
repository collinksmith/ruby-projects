require_relative 'spec_helper'

describe Queen do
  before :each do
    @board = Board.new
    @queen = Queen.new([4,4], @board, :white)
  end

  describe ".check_move" do
    it "can move diagonally" do
      expect(@queen.check_move([6,6])).to eq(true)
      expect(@queen.check_move([0,0])).to eq(true)
    end

    it "can move along a row" do
      expect(@queen.check_move([7,4])).to eq(true)
      expect(@queen.check_move([0,4])).to eq(true)
    end

    it "can move along a column" do
      expect(@queen.check_move([4,7])).to eq(true)
      expect(@queen.check_move([4,0])).to eq(true)
    end

    it "cannot move to another square" do
      expect { @queen.check_move([5,6]) }.to raise_error(ArgumentError)
    end

  end
end