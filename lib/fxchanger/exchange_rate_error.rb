module Fxchanger
  # Internal: Error class for representing errors that occur during converting exchange rates.
  class ExchangeRateError < ::StandardError
    # Internal: Initialize an ExchangeRateError object.
    #
    # message - The String error message.
    def initialize(msg)
      super(msg)
    end
  end
end
