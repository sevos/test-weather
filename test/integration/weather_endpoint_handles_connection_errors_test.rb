require 'test_helper'

class WeatherEndpointHandlesConnectionErrorsTest < ActionDispatch::IntegrationTest

  test "returns unknown" do
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?lat=35.0&lon=139.0").
      to_raise(SocketError)
    get "/api/v1/weather?lon=139&lat=35"
    data = JSON.parse(response.body)
    assert_equal({
                   'description' => "unknown",
                   "temperature" => "unknown",
                   "wind_speed" => "unknown"
                 }, data)
  end

  test "returns cached value" do
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?lat=35.0&lon=139.0").
      to_return(status: 200, body: File.read(Rails.root.join('test', 'fixtures', 'response_1.json')))
    WeatherStatus.create!(lon: 139, lat: 35)

    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?lat=35.0&lon=139.0").
      to_raise(SocketError)
    get "/api/v1/weather?lon=139&lat=35"
    data = JSON.parse(response.body)
    assert_equal({
                   'description' => "broken clouds",
                   "temperature" => 294.459,
                   "wind_speed" => 3.08
                 }, data)
  end
end
