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

  has_many :participants, -> { EventRegistration.accepted }, class_name: 'User', source: :user, through: :event_registrations
  has_many :tentative_participants, -> { EventRegistration.maybe }, class_name: 'User', source: :user, through: :event_registrations
  has_many :declined_participants, -> { EventRegistration.denied }, class_name: 'User', source: :user, through: :event_registrations

  scope :starting_after, -> (datetime) { where('starts_at > ?', DateTime.parse(datetime)) }
  scope :at_location, -> (location_name)  { joins(:location).where('locations.name like ?', "%#{location_name}%") }

  validates :name, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  accepts_nested_attributes_for :location, reject_if: :all_blank

  def participate!(user)
    clear_participations!(user)
    participants << user
  end

  def tentatively_participate!(user)
    clear_participations!(user)
    tentative_participants << user
  end

  def decline_participation!(user)
    clear_participations!(user)
    declined_participants << user
  end

  def clear_participations!(user)
    user.event_registrations.where(event_id: self.id).destroy_all
  end
end
