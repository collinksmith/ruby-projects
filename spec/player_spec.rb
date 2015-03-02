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

    context "when trying to move a piece that doesn't exist" do
      it "raises an error" do
        expect { @white_player.move([3,3], [4,4]) }.to raise_error(ArgumentError)
      end
    end

    context "when trying to move an opposig piece" do
      it "raises an error" do
        expect { @white_player.move([0,6]) }.to raise_error(ArgumentError)
      end
    end

    context "when taking an opposing piece" do
      it "removes a piece from the opposing player" do
        white_piece = Rook.new([4,4], @board, :white, @white_player)
        expect(@black_player.pieces.length).to eq(16)
        @white_player.move([4,4], [4,6])
        expect(@black_player.pieces.length).to eq(15)
      end

    end
  end

  describe ".castle" do
    context "when the way is open" do
      before :each do
        [@white_player, @black_player].each do |player|
          3.times {player.pieces[1].delete}
          2.times {player.pieces[2].delete}
        end
      end

      context "the white player" do
        it "can castle to the king side" do
          @white_player.castle('K')
          expect(@white_player.king.position).to eq([6,0])
        end

        it "can castle to the queen side" do  
          @white_player.castle('Q')
          expect(@white_player.king.position).to eq([2,0])
        end
      end

      context "the black player" do
        it "can castle to the king side" do
          @black_player.castle('K')
          expect(@black_player.king.position).to eq([6,7])
        end

        it "can castle to the king side" do
          @black_player.castle('Q')
          expect(@black_player.king.position).to eq([2,7])
        end
      end
    end

    context "when the way is shut. It was made by those who are dead. And the dead keep it" do
      context "the white player" do
        it "cannot castle to either side" do
          expect { @white_player.castle('K') }.to raise_error(ArgumentError)
          expect { @white_player.castle('Q') }.to raise_error(ArgumentError)
        end
      end
      context "the black player" do
        it "cannot castle to either side" do
          expect { @black_player.castle('K') }.to raise_error(ArgumentError)
          expect { @black_player.castle('Q') }.to raise_error(ArgumentError)
        end
      end
    end
  end
end