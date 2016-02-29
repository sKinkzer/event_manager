# == Schema Information
#
# Table name: event_registrations
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventRegistration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  STATUSES = %w(yes no maybe pending)

  scope :accepted, -> { where(status: 'yes') }
  scope :denied, -> { where(status: 'no') }
  scope :maybe, -> { where(status: 'maybe') }
  scope :pending, -> { where(status: 'pending') }

  validates :status, inclusion: { in: STATUSES }

  before_validation -> { self.status = 'pending' }, if: 'status.blank?'
end
