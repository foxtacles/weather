class WeatherController < ApplicationController
  def index
  end

  def forecast
    render turbo_stream: turbo_stream.replace("forecast", partial: "forecast", locals: daily_weather_and_current_temp)
  end

  private

  def daily_weather_and_current_temp
    record = Weather::Forecast.new(zip: params.require(:zip)).perform

    {
      daily_weather: record.daily_weather,
      current_temperature: record.current_temperature,
      is_cached: !record.updated_at_previously_changed?
    }
  end
end
