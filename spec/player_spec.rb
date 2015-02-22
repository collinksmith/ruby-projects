require 'spec_helper'

describe Player do
  before :each do
    @board = Board.new
    @player_x = Player.new('X', @board)
    @player_o = Player.new('O', @board)
  end

  it 'initializes with and X or O' do
    expect(@player_x.token).to eq('X')
    expect(@player_o.token).to eq('O')
  end

  describe 'play' do
    context 'when column is empty' do
      it 'changes the status of the bottom-most cell' do
        @player_x.play(1)
        expect(@board.cells[0][5].status).to eq('X')
      end
    end

    context 'when column is not empty' do
      it 'change the status of the bottom-most open cell' do
        @board.cells[0][5].status = 'O'
        @player_x.play(1)
        expect(@board.cells[0][4].status).to eq('X')
      end
    end

    context 'when column is full' do
      it 'raises an error' do
        0.upto(5) { |row| @board.cells[0][row].status = 'N' }
        expect { @player_x.play(1) }.to raise_error(ArgumentError)
      end
    end

  end
end