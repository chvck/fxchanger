module Fxchanger
  # Internal: Abstraction of a HTTP response object.
  class ExchangeResponse
    # Internal: Initialize a response.
    #
    # response - The HTTP response.
    def initialize(response)
      @response = response
    end

    # Internal: Was the request successful?
    #
    # Returns a Boolean whether or not the request was successful.
    def success?
      @response.success?
    end

    # Internal: Get the status code of the response
    #
    # Returns an Integer status code.
    def status_code
      @response.status
    end

    # Internal: Get the error message of the response
    #
    # Returns a String error message.
    def error_message
      @response.reason_phrase
    end

    # Internal: Get the body of the response
    #
    # Returns a body, format depends on response.
    def body
      @response.body
    end

    private
    # Returns the raw response.
    attr_reader :response

  end
end
