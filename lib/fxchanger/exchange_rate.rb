module Fxchanger
  # Public: Responsible for calculating exchange rates
  class ExchangeRate
    # Public - Calculate the exchange rate between two currencies for a given date
    #
    # date - the Date to lookup the exchange rates for
    # base_currency - the String currency to use for the base rate
    # other_currency - the String currency to use for the other rate
    #
    # Returns the conversion rate
    def self.at(date, base_currency, other_currency)
      repository = Fxchanger::ExchangeRepository.new Fxchanger.configuration.database_string
      begin
        exchange_converter = Fxchanger::ExchangeConverter.new repository
        return exchange_converter.at date, base_currency, other_currency
      ensure
        repository.disconnect
      end
    end

    # Public - Get the list of valid currencies
    #
    # Returns array of String currencies
    def self.currencies
      repository = Fxchanger::ExchangeRepository.new Fxchanger.configuration.database_string
      begin
        exchange_converter = Fxchanger::ExchangeConverter.new repository
        return exchange_converter.currencies
      ensure
        repository.disconnect
      end
    end
  end
end
