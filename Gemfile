source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.5"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.4"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Use FontAwesome icons [https://docs.fontawesome.com/web/use-with/ruby-on-rails]
gem "font-awesome-sass", "~> 6.5.2"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Make API calls with ease
gem "httparty"

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "hotwire-livereload", "~> 1.4"
  gem "web-console"
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Setting up Ruby objects as test data [https://github.com/thoughtbot/factory_bot_rails]
  gem "factory_bot_rails"

  # Generating fake data such as names, addresses, and phone numbers [https://github.com/faker-ruby/faker]
  gem "faker"

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Use RSpec for tests
  gem "rspec-rails", "~> 7.0"
end

group :test do
  # Brings back `assigns` and `assert_template` to your Rails tests [https://github.com/rails/rails-controller-testing]
  gem "rails-controller-testing"

  # Code coverage [https://github.com/simplecov-ruby/simplecov]
  gem "simplecov", require: false

  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end

# Use dotenv to load environment variables from .env into ENV
gem "dotenv-rails"
