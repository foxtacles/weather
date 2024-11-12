require 'rails_helper'

RSpec.describe Weather::Apis::Client, type: :module do
  let(:client) { Class.new { include Weather::Apis::Client }.new }
  let(:endpoint) { '/data/3.0/onecall' }
  let(:query) { { lat: 40.7128, lon: -74.0060 } }
  let(:response_data) { { "current" => { "temp" => 72 }, "daily" => [] } }
  let(:weather_record) { instance_double(WeatherRecord) }

  describe "#get" do
    context "when the data is available and up to date in the cache" do
      before do
        allow(client).to receive(:cache_for).and_return(1.minutes)
        allow(WeatherRecord).to receive(:find_or_initialize_by).and_return(weather_record)
        allow(weather_record).to receive(:new_record?).and_return(false)
        allow(weather_record).to receive(:updated_at).and_return(Time.current)
        allow(weather_record).to receive(:data).and_return(response_data)
      end

      it "returns the cached weather record" do
        result = client.get(endpoint, query: query)
        expect(result).to eq(weather_record)
        expect(WeatherRecord).to have_received(:find_or_initialize_by).with(
          endpoint: endpoint,
          query: query
        )
      end
    end

    context "when the data is not in the cache at all" do
      before do
        allow(WeatherRecord).to receive(:find_or_initialize_by).and_return(weather_record)
        allow(weather_record).to receive(:new_record?).and_return(true)
        allow(weather_record).to receive(:updated_at).and_return(1.day.ago)
        allow(weather_record).to receive(:data=)
        allow(weather_record).to receive(:save!)
        allow(client).to receive(:request).and_return(response_data)
      end

      it "makes an API call and saves the data" do
        result = client.get(endpoint, query: query)

        expect(result).to eq(weather_record)
        expect(weather_record).to have_received(:data=).with(response_data)
        expect(weather_record).to have_received(:save!)
      end
    end

    context "when the data is outdated" do
      before do
        allow(client).to receive(:cache_for).and_return(1.minutes)
        allow(WeatherRecord).to receive(:find_or_initialize_by).and_return(weather_record)
        allow(weather_record).to receive(:new_record?).and_return(true)
        allow(weather_record).to receive(:updated_at).and_return(1.day.ago)
        allow(weather_record).to receive(:data=)
        allow(weather_record).to receive(:save!)
        allow(client).to receive(:request).and_return(response_data)
      end

      it "makes an API call and saves the data" do
        result = client.get(endpoint, query: query)

        expect(result).to eq(weather_record)
        expect(weather_record).to have_received(:data=).with(response_data)
        expect(weather_record).to have_received(:save!)
      end
    end

    context "when the API call fails" do
      before do
        allow(WeatherRecord).to receive(:find_or_initialize_by).and_return(weather_record)
        allow(weather_record).to receive(:new_record?).and_return(true)
        allow(weather_record).to receive(:updated_at).and_return(1.day.ago)
        allow(weather_record).to receive(:data=)
        allow(weather_record).to receive(:save!)

        # Simulate a failed API request
        allow(client).to receive(:request).and_raise(Weather::Apis::Client::ApiError, "OpenWeatherMap API error: 500, Internal Server Error")
      end

      it "raises an ApiError" do
        expect {
          client.get(endpoint, query: query)
        }.to raise_error(Weather::Apis::Client::ApiError, "OpenWeatherMap API error: 500, Internal Server Error")
      end
    end
  end

  describe "#request" do
    it "makes a GET request to the OpenWeatherMap API" do
      # We will mock HTTParty to test the request method without actually hitting the API.
      response = double("response", code: 200, body: '{"current": {"temp": 72}}')
      allow(HTTParty).to receive(:send).and_return(response)

      result = client.send(:request, :get, endpoint, query)

      expect(HTTParty).to have_received(:send).with(:get, "http://api.openweathermap.org#{endpoint}", { query: query })
      expect(result).to eq(JSON.parse('{"current": {"temp": 72}}'))
    end

    it "raises an ApiError when the response is not successful" do
      response = double("response", code: 500, body: "Internal Server Error")
      allow(HTTParty).to receive(:send).and_return(response)

      expect {
        client.send(:request, :get, endpoint, query)
      }.to raise_error(Weather::Apis::Client::ApiError, "OpenWeatherMap API error: 500, Internal Server Error")
    end
  end
end
