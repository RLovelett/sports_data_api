require 'spec_helper'

describe SportsDataApi::Golf::Player, vcr: {
  cassette_name: 'sports_data_api_golf',
  record: :new_episodes,
  match_requests_on: [:host, :path]
} do
  let(:players) do
    SportsDataApi.set_access_level(:golf, 't')
    SportsDataApi.set_key(:golf, api_key(:golf))
    SportsDataApi::Golf.players(:pga, 2016)
  end

  context 'results from schedule fetch' do
    it 'populates each field' do
      subject = players.first
      expect(subject).to be_instance_of(SportsDataApi::Golf::Player)
      expect(subject.id).to eq '15a0ce0b-1c58-4aa2-8510-fe39a3684585'
      expect(subject.first_name).to eq 'Bill'
      expect(subject.last_name).to eq 'Glasson'
      expect(subject.height).to eq 71
      expect(subject.weight).to eq 175
      expect(subject.birthday).to eq Date.new(1960, 4, 29)
      expect(subject.country).to eq 'UNITED STATES'
      expect(subject.residence).to eq 'Stillwater, OK, USA'
      expect(subject.college).to eq 'Oral Roberts'
      expect(subject.turned_pro).to eq 1983
      expect(subject.member).to eq false
      expect(subject.updated).to eq DateTime.new(2016, 6, 8, 14, 53, 32)
    end
  end
end
