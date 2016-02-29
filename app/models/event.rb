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

class Event < ActiveRecord::Base
  belongs_to :location
  has_many :event_registrations
  has_many :users, through: :event_registrations

  has_many :participants, -> { EventRegistration.accepted }, through: :event_registrations
end
