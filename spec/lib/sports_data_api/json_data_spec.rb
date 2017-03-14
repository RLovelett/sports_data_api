require 'spec_helper'

module ManHole
  class FooBar < SportsDataApi::JsonData
    def zar
      'zar'
    end
  end
end

describe SportsDataApi::JsonData, '#[]' do
  it 'parses json and stores it as a hash' do
    subject = ManHole::FooBar.new({ foo: 'bar' })
    expect(subject.foo_bar[:foo]).to eq 'bar'
    expect(subject[:foo]).to eq 'bar'
    expect(subject[:bar]).to be_nil
  end

  it 'does not override methods' do
    subject = ManHole::FooBar.new({ foo: 'bar' })
    expect(subject[:zar]).to eq 'zar'
  end
end
