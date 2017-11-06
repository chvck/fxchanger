module FxchangerHarvest
  # Internal: Error class for representing errors that occur during web requests.
  class ResponseError < ::StandardError
    # Internal: The Integer status code.
    attr_reader :code
    # Internal: The String error message.
    attr_reader :message

    # Internal: Initialize a ResponseError object.
    #
    # response - The Response data.
    def initialize(response)
      @code = response.status_code
      @message = response.error_message

      super(formatted_message)
    end

    # Internal: Get the formatted error message.
    #
    # Returns a String formatted error message.
    def formatted_message
      "#{@message} (#{@code})"
    end

  end
end
