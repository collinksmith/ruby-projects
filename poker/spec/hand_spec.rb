require 'hand'
require 'rspec'


describe Hand do
  let(:s2) { double('s2', :value => :two, :suit => :spades) }
  let(:s3) { double('s3', :value => :three, :suit => :spades) }
  let(:s4) { double('s4', :value => :four, :suit => :spades) }
  let(:s5) { double('s5', :value => :five, :suit => :spades) }
  let(:s6) { double('s6', :value => :six, :suit => :spades) }
  let(:s7) { double('s7', :value => :seven, :suit => :spades) }
  let(:s8) { double('s8', :value => :eight, :suit => :spades) }
  let(:s9) { double('s9', :value => :nine, :suit => :spades) }
  let(:s10) { double('s10', :value => :ten, :suit => :spades) }
  let(:sj) { double('sj', :value => :jack, :suit => :spades) }
  let(:sq) { double('sq', :value => :queen, :suit => :spades) }
  let(:sk) { double('sk', :value => :king, :suit => :spades) }
  let(:sa) { double('sa', :value => :ace, :suit => :spades) }

  let(:h3) { double('h3' :value => :three, :suit => :hearts) }
  let(:h7) { double('h7' :value => :seven, :suit => :hearts) }
  let(:hq) { double('hq' :value => :queen, :suit => :hearts) }
  let(:d7) { double('d7' :value => :seven, :suit => :diamonds) }
  let(:c7) { double('c7' :value => :seven, :suit => :clubs) }
  let(:d4) { double('c3' :value => :four, :suit => :diamonds) }

  subject(:royal_flush_hand)     { Hand.new([s10, sj, sq, sk, sa]) }
  subject(:straight_flush_hand)  { Hand.new([s3, s4, s5, s6, s7]) }
  subject(:four_of_a_kind_hand)  { Hand.new([s7, h7, d7, c7, s2]) }
  subject(:full_house_hand)      { Hand.new([s7, h7, d7, sq, hq]) }
  subject(:flush_hand)           { Hand.new([s2, s4, s7, s9, sj]) }
  subject(:straight_hand)        { Hand.new([s5, s6, h7, s8, s9]) }
  subject(:three_of_a_kind_hand) { Hand.new([s7, h7, d7, hq, s3]) }
  subject(:two_pair_hand)        { Hand.new([s7, d7, sq, hq, s2]) }
  subject(:one_pair_hand)        { Hand.new([d4, h4, s2, s3, s4]) }
  subject(:ace_high_hand)        { Hand.new([sa, h7, hq, s3, s5]) }
  subject(:garbage_hand)         { Hand.new([s2, s5, s4, d7, h3]) }


  describe "#initialize" do
    context "when no args are given" do
      subject(:new_hand) { Hand.new }

      it "should be empty" do
        expect(new_hand.cards).to be_empty
      end
    end

    context "when args are given" do
      subject(:new_hand) { Hand.new([s2]) }

      it "has a card" do
        expect(new_hand.cards).not_to be_empty
      end
    end
  end

  describe "#straight_flush?" do
    context "for a real straight flush" do
      it "returns true for five cards in a row of the same suit" do
        expect(straight_flush_hand.straight_flush?).to be_true
      end
    end

    context "for not a straight flush" do
      it "returns false when not a straight flush" do
        expect(garbage_hand.straight_flush?).to be_false
      end
    end
  end

  describe "#four_of_a_kind?" do
    context "for a real four-of-a-kind" do
      it "returns true for four cards of the same value" do
        expect(four_of_a_kind_hand.four_of_a_kind?).to be_true
      end
    end

    context "for any other hand" do

      it "returns false when not four-of-a-kind" do
        expect(garbage_hand.four_of_a_kind?).to be_false
      end
    end
  end

  describe "#full_house?" do
    context "for a real full house" do
      it "returns true for three cards of one value and two cards of another" do
        expect(full_house_hand.full_house?).to be_true
      end
    end


    context "for any other hand" do
      it "returns false when not a full house" do
        expect(garbage_hand.full_house?).to be_false
      end
    end
  end
end
