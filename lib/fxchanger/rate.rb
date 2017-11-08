module Fxchanger
  # Internal: Object representing a rate for a given currency on a given date.
  class Rate
    # Internal: The BigDecimal rate of the currency.
    attr_reader :rate
    # Internal: The String currency being represented.
    attr_reader :currency
    # Internal: The String or Fixnum/Bignum date that the rate is valid for.
    attr_reader :date
    # Internal: The String name of the exchange.
    attr_reader :provider

    # Internal: Initialize a new Rate.
    #
    # rate  - The BigDecimal rate of the currency.
    # currency - The String currency being represented.
    # date - The String or Fixnum/Bignum date that the rate is valid for.
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
    # Returns a Fixnum/Bignum timestamp.
    def time_as_timestamp
      date = @date
      if @date.kind_of? String
        date = Date.parse(@date).to_time.to_i
      end

      date
    end

    # Internal: Override equals operator.
    #
    # other - The Mixed value to compare to
    #
    # Returns a Boolean whether or not the other value is equal to this one.
    def ==(other)
      unless other.kind_of?(Rate)
        return false
      end

      rates_equal = @rate == other.rate
      currency_equal = @currency == other.currency
      date_equal = @date == other.date
      provider_equal = @provider == other.provider
      rates_equal && currency_equal && date_equal && provider_equal
    end
  end
end
