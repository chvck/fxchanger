module Fxchanger
  # Interal: Responsible for calculating exchange rates
  class ExchangeConverter
    # Internal: Initialize an ExchangeConverter object.
    #
    # repository - The object to use for data source calls
    def initialize(repository)
      @repository = repository
    end

    # Internal - Calculate the exchange rate between two currencies for a given date
    #
    # date - the Date to lookup the exchange rates for
    # base_currency - the String currency to use for the base rate
    # other_currency - the String currency to use for the other rate
    #
    # Returns the conversion rate
    def at(date, base_currency, other_currency)
      # Markets tend to close on weekends so the rates are generally stable, so use the ones from Friday
      if date.saturday?
        date = date - 1
      elsif date.sunday?
        date = date - 2
      end

      base_rate = @repository.get_rate_at date, base_currency
      other_rate = @repository.get_rate_at date, other_currency

      if base_rate == nil
        raise Fxchanger::ExchangeRateError.new "Could not retrieve rate for #{base_currency} at #{date}"
      end

      if other_rate == nil
        raise Fxchanger::ExchangeRateError.new "Could not retrieve rate for #{other_currency} at #{date}"
      end

      other_rate / base_rate
    end

    private
    attr_reader :repository
  end
end
