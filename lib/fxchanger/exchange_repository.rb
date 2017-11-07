require "sequel"

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
    def save_many(records)
      records.each do |record|
        saving_record = record.clone
        @exchange.insert_conflict(:replace).insert({
          :rate => saving_record.rate,
          :date => saving_record.time_as_timestamp,
          :currency => saving_record.currency,
          :provider => saving_record.provider
        })
      end

    end

    private
    # The dataset for the rates table
    attr_reader :exchange
    # The database connection
    attr_reader :database
  end
end
