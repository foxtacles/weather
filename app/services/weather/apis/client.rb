module Weather
  module Apis
    module Client
      BASE_URL = "http://api.openweathermap.org".freeze

      class ApiError < StandardError; end

      # Makes a GET request to the specified endpoint and returns a cached record
      # if available. If the record is not found or is outdated, a new API call is made.
      #
      # This method attempts to fetch data from the OpenWeatherMap API and caches the result.
      # If the requested data is available in the cache (and is fresh enough),
      # it returns the cached data, avoiding the need for an expensive API call.
      #
      # @param endpoint [String] The API endpoint to request data from.
      # @param query [Hash] The query parameters to include in the request.
      #   Defaults to an empty hash.
      # @return [WeatherRecord] The weather record, either from cache or a new record
      #   saved after a successful API request.
      def get(endpoint, query: {})
        # First, let's see if we already have a record for the given query.
        # If yes, we return this record instead of making an (expensive) API call.
        # Note that in high concurrency environments, multiple requests may be issued
        # and running simultaneously before a record is saved. We allow this for now.
        record = WeatherRecord.find_or_initialize_by(
          {
            endpoint: endpoint,
            query: query
          }.compact
        )

        # Return the cached record if it's new or up to date, otherwise fetch new data.
        return record unless record.new_record? || record.updated_at < cache_for.ago

        # Make the API call and cache the result.
        record.data = request(:get, endpoint, query.merge(appid: Openweathermap.api_key))
        record.save!
        record
      end

      private

      def request(method, endpoint, query)
        response = HTTParty.send(method, BASE_URL + endpoint, { query: query })

        case response.code
        when 200
          JSON.parse(response.body)
        else
          raise ApiError, "OpenWeatherMap API error: #{response.code}, #{response.body}"
        end
      end

      # Returns the duration for which data should be cached.
      #
      # Must be implemented in each client that includes this module.
      #
      # @return [ActiveSupport::Duration] The duration for which data should be cached.
      def cache_for
        raise "Not implemented"
      end
    end
  end
end
