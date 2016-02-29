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
    @events = filter(Event.includes(:participants, :tentative_participants, :declined_participants, :location).order(:starts_at))
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

  def participate
    @event = Event.find(params[:id])
    @event.participate! current_user
    redirect_to events_path
  end

  def maybe
    @event = Event.find(params[:id])
    @event.tentatively_participate! current_user
    redirect_to events_path
  end

  def decline
    @event = Event.find(params[:id])
    @event.decline_participation! current_user
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :starts_at, :ends_at, :location_id, location_attributes: [:name, :address, :phone, :web_address])
  end

  def filter(events)
    if params[:filter].present?
      if params[:filter][:starts_at].present?
        events = events.starting_after(params[:filter][:starts_at])
      end
      if params[:filter][:location_name].present?
        events = events.at_location(params[:filter][:location_name])
      end
    end
    events    
  end
end
