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

  describe 'lowest_open_row' do
    context 'the column is empty' do
      it 'detects row 6' do
        expect(@board.lowest_open_row(0)).to eq(5)
      end
    end

    context 'the column is not empty' do
      it 'detects the lowest open row' do
        [*3..5].each { |i| @board.cells[0][i].status = 'X'}
        expect(@board.lowest_open_row(0)).to eq(2)
      end
    end
  end

  describe 'check_status' do
    context 'when player x has 4 in a row' do
      it 'detects horizontal win' do
        1.upto(4) { |i| @board.cells[i][2].status = 'X' }
        expect(@board.check_status).to eq("Player X wins")
      end

      it 'detects vertical win' do
        1.upto(4) { |i| @board.cells[2][i].status = 'X' }
        expect(@board.check_status).to eq("Player X wins")
      end

      it 'detects top-left to bottom-right diagonal win' do 
        [[3,2],[4,3],[5,4],[6,5]].each { |column, row| @board.cells[column][row].status = 'X' }
        expect(@board.check_status).to eq("Player X wins")
      end

      it 'detects bottom-left to top-right diagonal win' do
        [[3,3],[4,2],[5,1],[6,0]].each { |column, row| @board.cells[column][row].status = 'X' }
        expect(@board.check_status).to eq("Player X wins")
      end
    end

    context 'when no spots are left' do
      it 'detects a tie' do
        0.upto(6) do |column|
          0.upto(5) { |row| @board.cells[column][row].status = 'N' }
        end
        expect(@board.check_status).to eq("Tie game")
      end
    end

    context "when there is no winner or tie" do
      it 'returns false' do
        expect(@board.check_status).to eq(nil)
      end
    end
  end
end