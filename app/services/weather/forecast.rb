module Weather
  class Forecast
    # Initializes the Forecast service with a ZIP code.
    #
    # @param zip [String] The ZIP code for which the forecast is to be retrieved.
    def initialize(zip:)
      @zip = zip
    end

    # Retrieves the weather forecast based on the ZIP code.
    #
    # This method fetches geolocation data using the ZIP code
    # and then retrieves the forecast using the latitude and longitude
    # of the location.
    #
    # @return [WeatherRecord] The result of the forecast API call.
    def perform
      forecast
    end

    private

    def geocoding
      @geocoding ||= Apis::Geocoding::Client.new(zip: @zip).perform
    end

    def forecast
      @forecast ||= Apis::Forecast::Client.new(**geocoding.lat_and_lon).perform
    end
  end
end
