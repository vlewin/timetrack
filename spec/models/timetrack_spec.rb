require 'rails_helper'

describe Timetrack, type: :model do
  subject { described_class }
  let(:user) { Fabricate(:user) }
  let(:timetrack) { user.timetracks.first }

  describe '.find_by_month' do
    it 'finds user timetracks by month' do
      expect(subject.find_by_month(timetrack.date, user)).not_to be_empty
      expect(subject.find_by_month(timetrack.date, user)).to include(timetrack)
    end
  end

  describe '#balance' do
    it 'calculates a difference between actual-/desired hours of work (in minutes)' do
      expect(timetrack.balance).to eq 30
    end

    it 'returns 0 for not persisted record' do
      new_timetrack = Timetrack.new(date: Date.today)
      expect(new_timetrack.duration).to eq 0
    end
  end

  describe '#pause' do
    describe 'calculates a pause by reference to the § 4 ArbZG' do
      it '0 min if less than 6 hours' do
        allow(timetrack).to receive(:duration_in_hours).and_return 5
        expect(timetrack.pause).to eq 0
      end

      it '30 min if between 6 and 9 hours' do
        allow(timetrack).to receive(:duration_in_hours).and_return 8
        expect(timetrack.pause).to eq 30
      end

      it '45 min if more than 9 hours' do
        allow(timetrack).to receive(:duration_in_hours).and_return 10
        expect(timetrack.pause).to eq 45
      end
    end
  end

  describe '#duration' do
    it 'calculates duration from start and end time (in minutes)' do
      expect(timetrack.duration).to eq 540
    end

    it 'returns 0 if end time is not set' do
      timetrack.finish = nil
      expect(timetrack.duration).to eq 0
    end
  end

  describe '#duration_in_hours' do
    it 'converts duration to hours' do
      expect(timetrack.duration_in_hours).to eq 9
    end
  end

  describe '#duration_in_words' do
    it 'converts duration to time string e.g. 8 hr 30 min' do
      expect(timetrack.duration_in_words).to eq '9 hr 00 min'
    end
  end

  describe '#duration_in_percent' do
    it 'calculates  percent complete duration' do
      expect(timetrack.duration_in_percent).to eq 105
    end
  end
end
