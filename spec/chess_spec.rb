require_relative 'spec_helper.rb'

describe ".convert_position" do
  it "takes a human-readable position to a computer-readable position" do
    expect(convert_position(['a', '1'])).to eq([0, 0])
  end
end

describe ".player_turn" do
  before :each do
    @game = Game.new
  end

  # TODO: Learn how to test user input
  
  # context "when white player is moving" do
  #   it "allows a legal move" do
  #     expect(player_turn(@game.white_player))
  #   end
  # end
end