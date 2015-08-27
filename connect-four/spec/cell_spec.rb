require 'spec_helper'

describe Cell do
  before :each do
    @cell = Cell.new
  end

  it 'is initialized as an empty space' do
    expect(@cell.status).to eq(' ')
  end

  it 'prints its status' do
    expect(@cell.to_s).to eq(@cell.status)
  end
end