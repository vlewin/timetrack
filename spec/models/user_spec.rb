require 'rails_helper'

describe User, type: :model do
  subject { described_class }
  let(:user) { Fabricate(:user) }

  describe '.find_first_by_auth_conditions' do
    it 'finds the user by username' do
      expect(subject.find_first_by_auth_conditions({ login: user.username }).username).to eq user.username
    end

    it 'finds the user by email' do
      expect(subject.find_first_by_auth_conditions({ login: user.email }).email).to eq user.email
    end
  end

  describe '#balance' do
    it 'calculates overall balance' do
      expect(user.balance).to eq '1 hr 30 min'
    end
  end
end
