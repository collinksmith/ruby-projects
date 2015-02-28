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

    context "up the same column" do
      it "detects if a piece is in the way" do
        blocking_piece = Piece.new([1, 4], @board, :black, 'P')
        expect { @piece.check_move([1, 6]) }.to raise_error(ArgumentError)
      end
    end

    context "down the same column" do
      it "detects if a piece is in the way" do
        @piece.set_position([1, 7])
        blocking_piece = Piece.new([1, 4], @board, :white, 'P')
        expect { @piece.check_move([1, 0]) }.to raise_error(ArgumentError)
      end
    end

    context "up the same row" do
      it "detects if a piece is in the way" do
        blocking_piece = Piece.new([4, 1], @board, :black, 'P')
        expect {@piece.check_move([7, 1]) }.to raise_error(ArgumentError)
      end
    end

    context "down the same row" do
      it "detects if a piece is in the way" do
        @piece.set_position([4, 1])
        blocking_piece = Piece.new([3, 1], @board, :white, 'P')
        expect { @piece.check_move([2, 1]) }.to raise_error(ArgumentError)
      end
    end

    context "diagonally from bottom left to top right" do
      it "detects if a piece is in the way" do
        blocking_piece = Piece.new([4, 4], @board, :black, 'P')
        expect { @piece.check_move([5, 5]) }.to raise_error(ArgumentError)
      end
    end

    context "diagonally from top right to bottom left" do
      it "detects if a piece is in the way" do
        @piece.set_position([4, 6])
        blocking_piece = Piece.new([3, 5], @board, :white, 'P')
        expect { @piece.check_move([2, 4]) }.to raise_error(ArgumentError)
      end
    end

    context "diagonally from top left to bottom right" do
      it "detects if a piece is in the way" do
        @piece.set_position([1, 6])
        blocking_piece = Piece.new([3, 4], @board, :black, 'P')
        expect { @piece.check_move(5, 2) }.to raise_error(ArgumentError)
      end
    end

    context "diagonally from bottom right to top left" do
      it "detects if a piece is in the way" do
        @piece.set_position([4, 1])
        blocking_piece = Piece.new([3, 2], @board, :white, 'P')
        expect { @piece.check_move([2, 3]) }.to raise_error(ArgumentError)
      end
    end
  end



end