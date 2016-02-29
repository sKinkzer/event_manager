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

class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @locations = Location.all
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path
    else
      render action: :new
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :starts_at, :ends_at)
  end
end
