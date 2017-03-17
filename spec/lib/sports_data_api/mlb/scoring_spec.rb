require 'spec_helper'

describe SportsDataApi::Mlb::Scoring do
  context 'when no scoring array' do
    subject { SportsDataApi::Mlb::Scoring.new(nil) }

    its(:inning) { should be_nil }
    its(:inning_half) { should be_nil }
  end

  context 'when empty scoring' do
    subject { SportsDataApi::Mlb::Scoring.new([]) }

    its(:inning) { should be_nil }
    its(:inning_half) { should be_nil }
  end

  context 'when 9 innings and scores' do
    it 'returns the innings and no half inning' do
      data = (1..9).to_a.each_with_object([]) do |num, arr|
        arr.push({
          'number' => num, 'sequence' => num,
          'runs' => 0, 'type' => 'inning'
        })
      end
      subject = SportsDataApi::Mlb::Scoring.new(data)

      expect(subject.inning).to eq 9
      expect(subject.inning_half).to eq 'bot'
    end
  end

  context 'when top 7 innings and scores' do
    it 'returns the innings and no half inning' do
      data = (1..7).to_a.each_with_object([]) do |num, arr|
        arr.push({
          'number' => num, 'sequence' => num,
          'runs' => (num == 7 ? 'X' : 0), 'type' => 'inning'
        })
      end
      subject = SportsDataApi::Mlb::Scoring.new(data)

      expect(subject.inning).to eq 7
      expect(subject.inning_half).to eq 'top'
    end
  end

  context 'when bottom 6 innings and scores' do
    it 'returns the innings and no half inning' do
      data = (1..6).to_a.each_with_object([]) do |num, arr|
        arr.push({
          'number' => num, 'sequence' => num,
          'runs' => 0, 'type' => 'inning'
        })
      end
      subject = SportsDataApi::Mlb::Scoring.new(data)

      expect(subject.inning).to eq 6
      expect(subject.inning_half).to eq 'bot'
    end
  end
end
