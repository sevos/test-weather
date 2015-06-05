require 'open-uri'

module WeatherService
  extend self

  def fetch(lon:, lat:)
    open("http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}").read
  end
end
