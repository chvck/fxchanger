module FxchangerHarvest
  # Internal: Abstraction of a HTTP response object.
  class Response
    # Internal: Initialize a harvester.
    #
    # response - The HTTP response.
    def initialize(response)
      @response = response
      @body = response.body
    end

    private
    # Returns the raw response.
    attr_reader :response
    # Returns the body of the response.
    attr_reader :body

  end
end
