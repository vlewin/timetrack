require 'rails_helper'

describe Absence, type: :model do
  subject { Fabricate(:absence) }
  let(:user) { subject.user }

  it { should validate_presence_of :date }
  it { should validate_presence_of :user }
end
