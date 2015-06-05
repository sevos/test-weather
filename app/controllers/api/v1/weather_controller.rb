class Api::V1::WeatherController < ApplicationController
  CACHE_TIMEOUT = 10.minutes

  def show
    @weather = WeatherStatus.new(weather_params)
    @weather.save!
  rescue WeatherService::UnavailableError
    # I would even use geokit-rails gem here to display weather
    # from a location nearby.
    @weather = WeatherStatus.where(weather_params).
               where("created_at > ?", CACHE_TIMEOUT.ago).
               first || WeatherStatus.new
  rescue ActiveRecord::RecordInvalid
    render json: {errors: @weather.errors.full_messages}, status: 422
  end

  private

  def weather_params
    params.permit(:lon, :lat)
  end
end
