class EarthquakesController < ApplicationController
  include ActionController::MimeResponds

  def index
    @earthquakes = Earthquake.all
    # binding.pry

    respond_to do |format|
      format.json { render json: @earthquakes }
    end
  end

  def default_serializer_options
    { root: false }
  end
end
