class WeatherRecord < ApplicationRecord
  # This model is meant to store and cache results from the OpenWeatherMap APIs.
  # The `data` JSON blob contains the unaltered responses from the API endpoints.
  #
  # At this point, since we don't have any JSON schemas or OpenAPI specifications,
  # please refer to https://openweathermap.org/api and subsequent pages for
  # documentation on the data layout.

  def lat_and_lon
    {
      lat: data["lat"],
      lon: data["lon"]
    }
  end

  def daily_weather
    data["daily"].sort_by { |element| element["dt"] }
  end

  def current_temperature
    data.dig("current", "temp")
  end
end
