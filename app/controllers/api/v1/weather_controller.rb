class Api::V1::WeatherController < ApplicationController
  def show
    @weather = WeatherStatus.new(weather_params)
    @weather.save!
  end

  private

  def weather_params
    # here I would use some model for validating the params
    params.permit(:lon, :lat)
  end
end
