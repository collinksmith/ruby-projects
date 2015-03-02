require_relative 'spec_helper.rb'

describe Game do
  before :each do
    @game = Game.new
  end

  context "when player is not in check" do
    describe ".check?" do
      it "returns false" do
        expect(@game.check?(:black)).to eq(false)
      end
    end
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

    describe ".checkmate?" do
      context "when there is only one attacking piece" do
        it "returns false if the defender can move in front of it" do
          @game.white_player.move([4,1], [4,2])
          @game.black_player.move([5,6], [5,5])
          @game.white_player.move([3,0], [7,4])
          expect(@game.checkmate?(:black)).to eq(false)
        end

        it "returns true if the defender can't block or capture it" do
          @game.white_player.move([4,1], [4,2])
          @game.black_player.move([5,6], [5,5])
          @game.white_player.move([3,0], [7,4])
          @game.black_player.move([6,6], [6,4])
          expect(@game.checkmate?(:black)).to eq(true)
        end

        it "returns false if the defender can capture it" do
          @game.white_player.move([4,1], [4,2])
          @game.black_player.move([5,6], [5,4])
          @game.white_player.move([3,0], [7,4])
          @game.black_player.move([6,6], [6,4])
          @game.black_player.move([6,7], [5,5])
          expect(@game.checkmate?(:black)).to eq(false)
        end

        it "returns false if the king can move out of check" do
          @game.white_player.move([4,1], [4,2])
          @game.black_player.move([5,6], [5,5])
          @game.white_player.move([3,0], [7,4])
          @game.black_player.move([6,6], [6,4])
          @game.black_player.move([4,6], [4,5])
          expect(@game.checkmate?(:black)).to eq(false)
        end
      end

      context "when there are two attacking pieces" do
        context "when the king can't move out of danger" do
          it "returns true even if the pieces can be blocked" do
            @game.white_player.move([4,1], [4,2])
            @game.black_player.move([5,6], [5,5])
            @game.white_player.move([3,0], [7,4])
            @game.black_player.move([3,6], [3,5])
            @game.white_player.move([5,0], [1,4])
            expect(@game.checkmate?(:black)).to eq(true)
          end
        end

        context "when the king can move out of danger" do
          it "returns false" do
            @game.white_player.move([4,1], [4,2])
            @game.black_player.move([5,6], [5,5])
            @game.white_player.move([3,0], [7,4])
            @game.black_player.move([3,6], [3,5])
            @game.white_player.move([5,0], [1,4])
            @game.black_player.move([4,6], [4,5])
            expect(@game.checkmate?(:black)).to eq(false)
          end
        end
      end
    end
  end

end