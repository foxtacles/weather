module Weather
  module Apis
    module Geocoding
      # The Geocoding::Client class interacts with the OpenWeatherMap API's
      # geocoding endpoint to retrieve latitude and longitude for the given
      # ZIP code.
      class Client
        include Apis::Client

        def initialize(zip:)
          @zip = zip
        end

        def perform
          get(ENDPOINT, query: { zip: "#{@zip},US" })
        end

        private

        ENDPOINT = "/geo/1.0/zip".freeze

        def cache_for
          1.day
        end
      end
    end
  end
end
