require 'rails_helper'

RSpec.describe WeatherController, type: :request do
  describe "GET #forecast" do
    let(:zip_code) { '10001' }
    let(:daily_weather) { [ { "dt" => 1, "temp" => { "min" => 1, "max" => 2 } } ] }
    let(:current_temperature) { 72 }

    before do
      weather_record = instance_double(WeatherRecord)
      allow(Weather::Forecast).to receive(:new).with(zip: zip_code).and_return(double(perform: weather_record))

      # Stub methods on the weather record instance
      allow(weather_record).to receive(:daily_weather).and_return(daily_weather)
      allow(weather_record).to receive(:current_temperature).and_return(current_temperature)
      allow(weather_record).to receive(:updated_at_previously_changed?).and_return(false)

      # Make the request to the forecast action
      post forecast_path, params: { zip: zip_code }
    end

    it "returns a 200 OK response" do
      expect(response).to have_http_status(:ok)
    end

    it "renders the forecast partial with turbo_stream replacement" do
      expect(response).to render_template(partial: "_forecast")
    end
  end
end
