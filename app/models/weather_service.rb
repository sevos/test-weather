require 'open-uri'

module WeatherService
  class UnavailableError < Exception; end
  extend self

  def fetch(lon:, lat:)
    open("http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}").read
  rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
         Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError,
         SocketError

    raise UnavailableError
  end
end
