class WeatherStatus < ActiveRecord::Base
  validates :lat, :lon, numericality: true

  before_create :fetch_weather

  def description
    weather_node.fetch("description", "unknown")
  end

  def temperature
    response.fetch("main", {}).fetch("temp", "unknown")
  end

  def wind_speed
    response.fetch("wind", {}).fetch("speed", "unknown")
  end

  private

  def fetch_weather
    self.response = WeatherService.fetch(lon: lon, lat: lat)
  end

  def weather_node
    response.fetch("weather", []).first || {}






  end
end
