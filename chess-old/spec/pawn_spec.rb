require_relative 'spec_helper'

describe Pawn do
  before :each do
    @board = Board.new
    @pawn = Pawn.new([1,1], @board, :white)
    @black_pawn = Pawn.new([1,6], @board, :black)
  end

  context "when created" do
    it "is a subclass of Piece" do
      expect(@pawn.class.superclass).to eq(Piece)
    end

    it "sets its position" do
      expect(@board.cells[1][1].to_s).to eq('P')
    end
  end

  describe '.check_move' do
    it "can't move to a random spot" do
      expect { @pawn.check_move[7,2] }.to raise_error(ArgumentError)
    end
    
    context "when color is white" do
      it "detects if the square is occupied by a friendly piece" do
        blocking_piece = Pawn.new([1,2], @board, :white,)
        expect { @pawn.check_move([1,2]) }.to raise_error(ArgumentError)
      end

      context "when moving diagonally" do
        it "can move if the square is occupied by an opposing piece" do
          opposing_piece = Pawn.new([2,2], @board, :black)
          expect(@pawn.check_move([2,2])).to eq(true)
        end

        it "can't move if the square is empty" do
          expect {@pawn.check_move[2,2] }.to raise_error(ArgumentError)
        end
      end

      context "when moving forward" do
        it "can move one square ahead" do
          expect(@pawn.check_move([1,2])).to eq(true)
        end

        it "can move two squares ahead if on row 1" do
          expect(@pawn.check_move([1,3])).to eq(true)
        end

        it "cannot move two squares ahead if not on row 1" do
          @pawn.set_position([1,2])
          expect { @pawn.check_move([1,4]) }.to raise_error(ArgumentError)
        end

        it "cannot move backward" do
          expect { @pawn.check_move([1,0]) }.to raise_error(ArgumentError)
        end

        it "cannot capture a piece in front of it" do 
          opposing_piece = Piece.new([1,2], @board, :black, 'P')
          expect { @pawn.check_move([1,2]) }.to raise_error(ArgumentError)
        end
      end
    end

    context "when color is black" do
      context "when moving diagonally" do
        it "can capture opposing piece diagonally" do
          opposing_piece = Piece.new([2,5], @board, :white, 'P')
          expect(@black_pawn.check_move([2,5])).to eq(true)
        end
      end

      context "when moving forward" do
        it "can move down two spaces if on row 6" do
          expect(@black_pawn.check_move([1,4])).to eq(true)
        end

        it "cannot capture a piece in front of it" do
          opposing_piece = Piece.new([1,5], @board, :white, 'P')
          expect { @black_pawn.check_move([1,5]) }.to raise_error(ArgumentError)
        end
      end
    
    end
  end

end