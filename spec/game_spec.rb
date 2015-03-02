require_relative 'spec_helper.rb'

describe Game do
  before :each do
    @game = Game.new
  end

  context "when player is in check" do
    describe ".check?" do
      it "returns true" do
        @game.white_player.move([4,1], [4,2])
        @game.black_player.move([5,6], [5,5])
        @game.white_player.move([3,0], [7,4])
        expect(@game.check?(:black)).to eq(true)
      end
    end
  end

end