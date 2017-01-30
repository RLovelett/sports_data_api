require 'spec_helper'

describe SportsDataApi::Player, '#[]' do
  it 'parses json and stores it as a hash' do
    subject = SportsDataApi::Player.new({ foo: 'bar' })
    expect(subject.player[:foo]).to eq 'bar'
    expect(subject[:foo]).to eq 'bar'
    expect(subject[:bar]).to be_nil
  end
end
