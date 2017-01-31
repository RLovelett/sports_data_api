require 'spec_helper'

describe SportsDataApi::Golf::Pairing do
  let(:data) {
    {
      'tee_time' => '2015-04-10T11:45:00+00:00',
      'back_nine' => false,
      'players' => [
        {
          'first_name' => 'Ian',
          'last_name' => 'Woosnam',
          'country' => 'WALES',
          'id' => 'f7f29a09-7e04-4d72-9e83-137f502b056f'
        },
        {
          'first_name' => 'Erik',
          'last_name' => 'Compton',
          'country' => 'UNITED STATES',
          'id' => '3f463f9f-12da-4896-b7e3-e1a2c9ae69a9'
        }
      ]
    }
  }
  subject { SportsDataApi::Golf::Pairing.new(data) }

  its(:tee_time) { should eq(DateTime.new(2015, 4, 10, 11, 45)) }
  its(:back_nine) { should eq(false) }

  it '#players parses players' do
    expect(subject.players.length).to eq 2
    player = subject.players.first
    expect(player).to be_an_instance_of(SportsDataApi::Golf::Player)
    expect(player[:id]).to eq 'f7f29a09-7e04-4d72-9e83-137f502b056f'
  end
end
