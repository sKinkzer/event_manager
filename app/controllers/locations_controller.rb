class LocationsController < ApplicationController
	def index

	end

	def search
		@locations = Location.where('name like ?', "%#{params[:q]}%")
		render json: @locations
	end
end