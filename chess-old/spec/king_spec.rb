require_relative 'spec_helper'

describe King do
  before :each do
    @board = Board.new
    @king = King.new([4,4], @board, :white)
  end

  describe ".check_move" do
    context "when moving no more than one square away" do
      it "can move diagonally" do
        expect(@king.check_move([5,5])).to eq(true)
        expect(@king.check_move([3,3])).to eq(true)
        expect(@king.check_move([3,5])).to eq(true)
        expect(@king.check_move([5,3])).to eq(true)
      end

      it "can move along a column" do
        expect(@king.check_move([4,5])).to eq(true)
        expect(@king.check_move([4,3])).to eq(true)
      end

      it "can move along a row" do
        expect(@king.check_move([5,4])).to eq(true)
        expect(@king.check_move([3,4])).to eq(true)
      end
    end

    context "when moving more than one square away" do
      it "cannot move diagonally" do
        expect { @king.check_move([6,6]) }.to raise_error(ArgumentError)
        expect { @king.check_move([6,2]) }.to raise_error(ArgumentError)
      end

      it "cannot move along a column" do
        expect { @king.check_move([4,6]) }.to raise_error(ArgumentError)
      end

      it "cannot move along a row" do
        expect { @king.check_move([6,4]) }.to raise_error(ArgumentError)
      end
    end
  end
end