require_relative 'spec_helper'

describe Cell do
  before :each do
    @cell = Cell.new
  end

  context "when created" do
    it "prints an empty space" do
      expect(@cell.to_s).to eq(' ')
    end

  end
end