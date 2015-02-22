require 'spec_helper'

describe new_game do
  it 'returns player_x, player_o, and a board' do
    X, O, board = new_game
    expect(X.is_a?(Player)).to eq(true)
    expect(O.is_a?(Player)).to eq(true)
    expect(board.is_a?(Board)).to eq(true)
  end
end

# describe choose_column do
#   context 'player_x' do

#   end
# end