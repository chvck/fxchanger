# Fxchanger

Gem for converting between different currencies using a specific exchange web endpoint.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fxchanger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fxchanger

## Usage

The gem is made up of two concepts: retrieving conversion rates and harvesting exchange data.

Before accessing anything within the fxchanger gem it must be configured with the database connection string. To set this
up use `Fxchanger.configuration.database_string = "database_string_here"` from your application.

To use the conversion API is simply a call to `Fxchanger::ExchangeRate.at(date, base_currency, counter_currency)`. There is 
also a helper method at `Fxchanger::ExchangeRate.currencies` to retrieve all valid currencies from the database.

The harvester is accessible via `Fxchanger::Harvester`. It requires a `Fxchanger::HarvestDetails` object containing the exchange
endpoint and response data type. It can also receive a converter object, this will be used for converting the reponse from the endpoint
to a list of `Fxchanger::Rate` objects. The object must expose the interface in `Fxchanger::DataSourceConverter`, see `EcbSourceConverter`.

The harvester can also be run from within the gem using `bundle exec harvest`, this script takes the endpoint and the database connection
string as arguments. It also takes some options, see `bundle exec harvester -h`. There is also a sample cron file at `bin/harvest.cron`.

Database tables are created automatically by the harvester, the harvester must be run before the library can be used.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle install`.
