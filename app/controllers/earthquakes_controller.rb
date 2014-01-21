class EarthquakesController < ApplicationController
  include ActionController::MimeResponds


  def index
    scope = Earthquake.all_quakes

    scope = scope.since_quake(Time.zone.at(params[:since].to_i).to_date) if params[:since]
    scope = scope.on_day(Time.zone.at(params[:on].to_i).to_date) if params[:on]
    scope = scope.mag_over(params[:over]) if params[:over]
    if params[:near]
      latlong = params[:near].split(",")
      lat = latlong.split(",")[0]
      long = latlong.split(",")[1]
      scope = scope.near(lat, long)
    end
    # binding.pry

    respond_to do |format|
      format.json { render json: scope }
    end
  end

  def default_serializer_options
    { root: false }
  end
end
