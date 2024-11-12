module Weather
  module Apis
    module Forecast
      # The Forecast::Client class interacts with the OpenWeatherMap API's
      # one-call endpoint to retrieve weather forecast data for a specific
      # latitude and longitude.
      class Client
        include Apis::Client

        def initialize(lat:, lon:)
          @lat = lat
          @lon = lon
        end

        def perform
          get(ENDPOINT, query: { lat: @lat, lon: @lon, units: "imperial" })
        end

        private

        ENDPOINT = "/data/3.0/onecall".freeze

        def cache_for
          30.minutes
        end
      end
    end
  end
end
