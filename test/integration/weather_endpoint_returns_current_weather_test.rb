require 'test_helper'

class WeatherEndpointReturnsCurrentWeatherTest < ActionDispatch::IntegrationTest

  setup do
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?lat=35.0&lon=139.0").
        to_return(status: 200, body: File.read(Rails.root.join('test', 'fixtures', 'response_1.json')))
  end

  test "returns current weather" do
    get "/api/v1/weather?lon=139&lat=35"

    data = JSON.parse(response.body)

    assert_equal({
                   'description' => "broken clouds",
                   "temperature" => 294.459,
                   "wind_speed" => 3.08
                 }, data)
  end
end
