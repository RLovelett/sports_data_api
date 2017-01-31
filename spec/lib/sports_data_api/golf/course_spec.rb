require 'spec_helper'

describe SportsDataApi::Golf::Course do
  let(:data) {
    {
      'name' => 'Augusta National',
      'yardage' => 7435,
      'par' => 72,
      'id' => '7e9462a5-66ea-4205-b37a-81884e3653cf',
      'pairings' => [
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
      ]
    }
  }
  subject { SportsDataApi::Golf::Course.new(data) }

  its(:name) { should eq('Augusta National') }
  its(:yardage) { should eq(7435) }
  its(:par) { should eq(72) }
  its(:id) { should eq('7e9462a5-66ea-4205-b37a-81884e3653cf') }

  it '#pairings parses pairs' do
    expect(subject.pairings.length).to eq 1
    pair = subject.pairings.first
    expect(pair).to be_an_instance_of(SportsDataApi::Golf::Pairing)
  end
end
