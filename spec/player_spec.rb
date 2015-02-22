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

  it 'changes the token of a cell' do
    @player_x.play(1)
    expect(@board.cells[0][5].status).to eq('X')
  end


end