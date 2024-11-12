require 'rails_helper'

RSpec.describe Weather::Apis::Geocoding::Client, type: :module do
  let(:zip_code) { '10001' }
  let(:client) { described_class.new(zip: zip_code) }
  let(:endpoint) { "/geo/1.0/zip" }
  let(:query) { { zip: "#{zip_code},US" } }

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
