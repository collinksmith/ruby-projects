require_relative 'spec_helper'

describe Pawn do
  before :each do
    @board = Board.new
    @pawn = Pawn.new([1,1], @board, :white)
  end

  context "when created" do
    it "is a subclass of Piece" do
      expect(@pawn.class.superclass).to eq(Piece)
    end

    it "sets its position" do
      expect(@board.cells[1][1].to_s).to eq('P')
    end
  end

end