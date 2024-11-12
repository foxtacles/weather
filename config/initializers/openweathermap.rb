class Openweathermap
  def self.api_key
    Rails.application.credentials.dig(:openweathermap, :api_key)
  end
end
