module Fxchanger
  # Internal: Object representing a rate for a given currency on a given date.
  class Rate
    # Internal: The Float rate of the currency.
    attr_reader :rate
    # Internal: The String currency being represented.
    attr_reader :currency
    # Internal: The String or Bignum date that the rate is valid for.
    attr_reader :date
    # Internal: The String name of the exchange.
    attr_reader :provider

    # Internal: Initialize a new Rate.
    #
    # rate  - The Float rate of the currency.
    # currency - The String currency being represented.
    # date - The String or Bignum date that the rate is valid for.
    # provider - The String name of the exchange.
    #
    # Examples
    #
    #   Rate.new(7.4028, "HRK", "2017-08-11", "European Central Bank")
    def initialize(rate, currency, date, provider)
      @rate = rate
      @currency = currency
      @date = date
      @provider = provider
    end

    # Internal: Get the date as a UNIX timestamp.
    #
    # Examples
    #
    #   time_as_timestamp
    #   # => 1502233200
    #
    # Returns a Bignum timestamp.
    def time_as_timestamp
      date = @date
      if @date.kind_of? String
        date = Date.parse(@date).to_time.to_i
      end

      date
    end
  end
end
