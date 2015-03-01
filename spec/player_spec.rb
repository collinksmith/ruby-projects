require_relative 'spec_helper'

describe Player do
  before :each do
    @board = Board.new
    @white_player = Player.new(@board, :white)
    @black_player = Player.new(@board, :black)
  end

  context "when created" do
    context "white player" do
      it "puts a rook on the first square" do
        expect(@board.get_piece([0,0]).type).to eq('R')
      end

      it "puts a pawn on the second row" do
        expect(@board.get_piece([7,1]).type).to eq('P')
      end
    end

    context "black player" do
      it "puts a rook on the last square" do
        expect(@board.get_piece([7,7]).type).to eq('R')
      end

      it "puts a pawn on the second to last row" do
        expect(@board.get_piece([3,6]).type).to eq('P')
      end
    end
  end

  describe ".move" do
    context "when making a legal move" do
      before :all do
        # @white_player.move([1,1], [1,3])
      end
      it "sets the piece on the old cell to nil" do
        @white_player.move([1,1], [1,3])
        expect(@board.get_piece([1,1])).to eq(nil)
      end

      it "sets updates the piece on the new cell" do
        @white_player.move([1,1], [1,3])
        expect(@board.get_piece([1,3]).type).to eq('P')
      end
    end

    context "when making an illegal move" do
      it "raises an error" do
        expect { @white_player.move([1,1], [1,4]) }.to raise_error(ArgumentError)
      end
    end

  end
end