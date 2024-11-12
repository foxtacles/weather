require 'rails_helper'

RSpec.describe WeatherRecord, type: :model do
  let(:valid_data) do
    {
      "lat" => 40.7128,
      "lon" => -74.0060,
      "current" => { "temp" => 72 },
      "daily" => [
        { "dt" => 3, "temp" => { "day" => 75 } },
        { "dt" => 2, "temp" => { "day" => 68 } },
        { "dt" => 1, "temp" => { "day" => 70 } }
      ]
    }
  end

  let(:weather_record) { build(:weather_record, data: valid_data) }

  describe "#lat_and_lon" do
    it "returns the correct latitude and longitude from the data" do
      expect(weather_record.lat_and_lon).to eq({ lat: 40.7128, lon: -74.0060 })
    end
  end

  describe "#daily_weather" do
    it "returns the daily weather sorted by timestamp (dt)" do
      sorted_weather = weather_record.daily_weather
      expect(sorted_weather.first["dt"]).to eq(1)
      expect(sorted_weather.second["dt"]).to eq(2)
      expect(sorted_weather.last["dt"]).to eq(3)
    end
  end

  describe "#current_temperature" do
    it "returns the correct current temperature" do
      expect(weather_record.current_temperature).to eq(72)
    end
  end
end
