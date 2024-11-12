require 'rails_helper'

RSpec.describe Weather::Apis::Forecast::Client, type: :module do
  let(:lat) { 40.7128 }
  let(:lon) { -74.0060 }
  let(:client) { described_class.new(lat: lat, lon: lon) }
  let(:endpoint) { "/data/3.0/onecall" }
  let(:query) { { lat: lat, lon: lon, units: "imperial" } }

  describe "#perform" do
    it "calls the get method with the correct endpoint and query" do
      # Mock the get method to avoid triggering the actual request logic
      allow(client).to receive(:get)

      # Call the perform method
      client.perform

      # Verify that the get method was called with the expected endpoint and query
      expect(client).to have_received(:get).with(endpoint, query: query)
    end
  end
end
