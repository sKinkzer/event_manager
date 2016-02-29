# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  starts_at   :datetime
#  ends_at     :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :integer
#
# Indexes
#
#  index_events_on_location_id  (location_id)
#

require 'rails_helper'
RSpec.describe Event, type: :model do

  it "has a valid factory" do
    expect(build(:event)).to be_valid
  end

  it { is_expected.to belong_to :location }
  it { is_expected.to have_many :event_registrations }
  it { is_expected.to have_many :users }

end
