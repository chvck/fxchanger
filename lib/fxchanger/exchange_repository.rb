module Fxchanger
  # Internal: Responsible for handling interactions with the rates table.
  class ExchangeRepository
    TABLE = :rates

    # Internal: Initialize a new ExchangeRepository.
    #
    # database_string  - The String database connection string used to connect to the exchange database.
    #
    # Examples
    #
    #   ExchangeRepository.new("sqlite://exchange.db")
    def initialize(database_string)
      @database = Sequel.connect(database_string)
      @exchange = @database[TABLE]
    end

    # Internal: Replace the current database connection with another.
    #
    # connection - The replacement connection.
    def set_connection(connection)
      if @database != nil
        @database.disconnect
      end
      @database = connection
      @exchange = @database[TABLE]
    end

    # Internal: Create the rates table if it doesn't exist.
    def create_table?
      @database.create_table? TABLE do
        primary_key :id

        Integer :date, :null => false
        String :currency, :null => false, :text => true
        Numeric :rate, :null => false
        String :provider, :null => false, :text => true

        unique [:date, :currency, :provider]
        index [:date, :currency]
      end
    end

    # Internal: Save an array of Rate records.
    #
    # records  - The array of Rate records.
    def save_many_rates(records)
      records.each do |record|
        record_hash = {
          :rate => record.rate,
          :date => record.time_as_timestamp,
          :currency => record.currency,
          :provider => record.provider
        }
        if 0 == @exchange.where(
          :date => record.time_as_timestamp,
          :currency => record.currency,
          :provider => record.provider
        ).update(rate: record.rate)
          @exchange.insert(record_hash)
        end
      end
    end

    # Internal: Get the date of the most recent record in the rates table.
    #
    # Returns the latest Date.
    def get_latest_date
      latest_date = @exchange.order(:date).reverse.select(:date).first
      if latest_date == nil
        return nil
      end

      time = Time.at latest_date[:date]
      Date.parse time.to_s
    end

    # Internal: Get the exchange rate at a given date for a given currency.
    #
    # date - The Date or String representation of the date to get the rate for, String in format YYYY-mm-dd.
    # currency - The currency to get the rate for.
    #
    # Returns the BigDecimal rate.
    def get_rate_at(date, currency)
      query_date = date
      if query_date.kind_of? String
        query_date = Date.parse(query_date)
      end

      query_date = query_date.to_time.to_i

      rate = @exchange.where(currency: currency, date: query_date).select(:rate).first
      unless rate == nil
        rate = rate[:rate]
      end

      rate
    end

    # Internal - Get the list of valid currencies
    #
    # Returns array of String currencies
    def currencies
      raw_currencies = @exchange.order(:currency).select(:currency).distinct()

      raw_currencies.map {|raw_currency| raw_currency[:currency]}
    end

    # Internal: Disconnect from the database.
    def disconnect
      @database.disconnect
    end

    private
    # The dataset for the rates table
    attr_reader :exchange
    # The database connection
    attr_reader :database
  end
end
