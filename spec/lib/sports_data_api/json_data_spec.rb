require 'spec_helper'

module ManHole
  class Foobar < SportsDataApi::JsonData ; end
end

describe SportsDataApi::JsonData, '#[]' do
  it 'parses json and stores it as a hash' do
    subject = ManHole::Foobar.new({ foo: 'bar' })
    expect(subject.foobar[:foo]).to eq 'bar'
    expect(subject[:foo]).to eq 'bar'
    expect(subject[:bar]).to be_nil
  end
end
