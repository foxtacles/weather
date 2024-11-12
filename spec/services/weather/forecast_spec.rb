require 'rails_helper'

RSpec.describe Weather::Forecast, type: :service do
  let(:zip_code) { '10001' }
  let(:forecast_service) { described_class.new(zip: zip_code) }

  let(:geocoding_record) { build(:weather_record, data: { "lat" => 40.7128, "lon" => -74.0060 }) }
  let(:forecast_record) do
    build(:weather_record, data: {
      "current" => { "temp" => 72 },
      "daily" => [
        { "dt" => 1, "temp" => { "day" => 70 } },
        { "dt" => 2, "temp" => { "day" => 68 } }
      ]
    })
  end

  describe "#initialize" do
    it "initializes with a zip code" do
      expect(forecast_service.instance_variable_get(:@zip)).to eq(zip_code)
    end
  end

  describe "#perform" do
    before do
      # Mock the geocoding and forecast API calls
      allow_any_instance_of(Weather::Apis::Geocoding::Client).to receive(:perform).and_return(geocoding_record)
      allow_any_instance_of(Weather::Apis::Forecast::Client).to receive(:perform).and_return(forecast_record)
    end

    it "calls the geocoding API to get lat and lon" do
      expect_any_instance_of(Weather::Apis::Geocoding::Client).to receive(:perform).and_return(geocoding_record)
      forecast_service.perform
    end

    it "calls the forecast API to get weather data" do
      expect_any_instance_of(Weather::Apis::Forecast::Client).to receive(:perform).and_return(forecast_record)
      forecast_service.perform
    end

    it "returns a weather forecast record with the correct data" do
      result = forecast_service.perform
      expect(result).to be_a(WeatherRecord)
      expect(result.data["current"]["temp"]).to eq(72)
      expect(result.data["daily"].first["temp"]["day"]).to eq(70)
    end
  end
end
