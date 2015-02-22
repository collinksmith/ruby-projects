require 'spec_helper.rb'

describe Board do
  before :each do
    @board = Board.new
  end

  it 'is initialized with seven columns' do
    expect(@board.cells.length).to eq(7)
  end

  it 'is initialized with six rows' do
    expect(@board.cells[0].length).to eq(6)
  end

  it 'displays the board' do
    output = capture_stdout {@board.display}
    expect(output).to eq("|_ _|_ _|_ _|_ _|_ _|_ _|_ _|\n|_ _|_ _|_ _|_ _|_ _|_ _|_ _|\n|_ _|_ _|_ _|_ _|_ _|_ _|_ _|\n|_ _|_ _|_ _|_ _|_ _|_ _|_ _|\n|_ _|_ _|_ _|_ _|_ _|_ _|_ _|\n|_ _|_ _|_ _|_ _|_ _|_ _|_ _|\n")
  end
end