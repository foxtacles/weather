# Start Here

Note: this application has been created within a timebox of 2-3 hours.

https://github.com/user-attachments/assets/e975b3a4-960d-4c24-b294-445f6a51556b

#### Clone the repository
`git clone git@github.com:foxtacles/weather.git`

#### Add OpenWeatherMap API key

This application requires an OpenWeatherMap API key and a "One Call API 3.0" subscription. To add the API key, edit the Rails credentials with `rails credentials:edit` and add:

```
openweathermap:
  api_key: your_key_here
```

Note that the first 1000 API calls are free of charge at the time of writing.

#### Create ENV files

Specify the database URLs in `.env` files for local development. For example:

```
# .env.development.local
DATABASE_URL=postgresql://localhost/weather_development
```

```
# .env.test.local
DATABASE_URL=postgresql://localhost/weather_test
```

#### Run tests

`weather` uses RSpec for tests. Run `bundle exec rspec` to run the entire test suite.

#### Start server

`rails s`
