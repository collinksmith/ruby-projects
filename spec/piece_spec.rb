require_relative 'spec_helper'

describe Piece do
  before :each do
    @board = Board.new
    @piece = Piece.new([1,1], @board, :white, 'P')
  end

  context "when created" do
    it "has a position 1,1" do
      expect(@piece.position).to eq([1,1])
    end

    it "sets its position on the board" do
      # @piece.set_position('P')
      expect(@board.cells[1][1].to_s).to eq('P')
    end
  end

  context "when moving" do
    it "detects if the move is off the board" do
      expect { @piece.check_move([9,9]) }.to raise_error(ArgumentError)
    end

    it "detects if the new position is occupied by a friendly piece" do
      @friendly_piece = Pawn.new([1,2], @board, :white)
      expect { @piece.check_move([1,2]) }.to raise_error(ArgumentError)
    end

    it "detects if the new position is the same as the old position" do
      expect { @piece.check_move([1,1]) }.to raise_error(ArgumentError)
    end

    context "when moving up the same column" do
      it "detects if a piece is in the way" do
        @blocking_piece = Piece.new([1, 4], @board, :black, 'P')
        expect { @piece.check_move([1, 6]) }.to raise_error(ArgumentError)
      end
    end
  end



end