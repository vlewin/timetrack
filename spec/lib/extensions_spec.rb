require "rails_helper"

describe 'extensions.rb' do
  let(:positive_number) { 60 }
  let(:negative_number) { -60 }

  describe String do
    describe '#negative?' do
      it 'determines if a number is positive or negative' do
        expect(negative_number.to_s.negative?).to be true
        expect(positive_number.to_s.negative?).to be false
      end
    end
  end

  describe Fixnum do
    describe '#negative?' do
      it 'determines if a number is positive or negative' do
        expect(negative_number.negative?).to be true
        expect(positive_number.negative?).to be false
      end
    end

    describe '#to_time' do
      it 'converts minutes to time string e.g. 60.to_time => "1 hr 00 min"' do
        expect(positive_number.to_time).to eq  '1 hr 00 min'
        expect(negative_number.to_time).to eq '-1 hr 00 min'
      end

      it 'dafaults to :short format' do
        expect(positive_number.to_time).to eq '1 hr 00 min'
      end

      it 'respects format parameter' do
        expect(positive_number.to_time(:short)).to eq '1 hr 00 min'
        expect(positive_number.to_time(:long)).to eq '1 hours 00 minutes'
      end
    end
  end
end


describe Date do
  describe '#weekend?' do
    it 'determines if a date falls on the weekend' do
      expect(Date.parse('2014-08-16').weekend?).to be true
      expect(Date.parse('2014-08-15').weekend?).to be false
    end
  end
end
