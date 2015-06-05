require 'test_helper'

class WeatherEndpointHandlesInvalidInputTest < ActionDispatch::IntegrationTest

  test "returns errors" do
    get "/api/v1/weather?lat=aaa"

    data = JSON.parse(response.body)

    assert_equal({
                   'errors' => [
                     'Lat is not a number',
                     'Lon is not a number'
                   ]
                 }, data)
    assert_equal 422, response.status
  end
end
