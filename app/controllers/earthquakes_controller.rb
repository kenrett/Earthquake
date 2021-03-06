class EarthquakesController < ApplicationController
  include ActionController::MimeResponds


  def index
    scope = Earthquake.all_quakes

    scope = scope.since_quake(Time.zone.at(params[:since].to_i).to_date) if params[:since]
    scope = scope.on_day(Time.zone.at(params[:on].to_i).to_date) if params[:on]
    scope = scope.mag_over(params[:over]) if params[:over]
    if params[:near]
      latlong = params[:near].split(",")
    # binding.pry
      lat = latlong[0].to_f
      # puts lat.class
      lng = latlong[1].to_f
      scope = scope.near(lat, lng)
    end

    respond_to do |format|
      format.json { render json: scope }
    end
  end

  def default_serializer_options
    { root: false }
  end
end
