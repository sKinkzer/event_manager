require 'rails_helper'

RSpec.describe EventRegistration, type: :model do
  it "has a valid factory" do
    expect(build(:event_registration)).to be_valid
  end

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :event }

  it { is_expected.to validate_inclusion_of(:status).in_array(%w(yes no maybe pending)) }
end
