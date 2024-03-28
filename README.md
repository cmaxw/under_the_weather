# Installation

This application was built on Ruby 3.3.0 and Rails 7.1.3. 

# External Requirements

In order to geocode addresses into latitude and longitude, you'll need an API key for <https://geocode.xyz>. Create an account and then go to your [account page](https://geocode.xyz/?account=1).

Geocoded results are stored in a PostgreSQL database and are only retrieved if not found in the database.

For the current weather, you'll need an API key for <https://openweathermap.org/>. Create an account and then browse to the [API key list](https://home.openweathermap.org/api_keys) to retrieve or create API keys.

For production, store these with your other secrets. This codebase assumes ENV variables, but you could refactor to use Rails' encrypted secrets instead.

For development, place your keys in a .env file under GEOCODE_AUTH_CODE and OPEN_WEATHER_API_KEY.

# Running in development

Weather results are cached in your Rails cache for 30 minutes. In order to see the caching, you'll need to turn on caching on in your development environment. Run `rails dev:cache` to toggle caching on and off.


