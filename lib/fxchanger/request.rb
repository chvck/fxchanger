module Fxchanger
  # Internal: Methods for fetching data from URLs.
  class Request

    # Public: Perform a get request on a URL.
    #
    # endpoint  - The String address to call against.
    # response_type - The Symbol content type that the response is expected to take.
    #
    # Examples
    #
    #   get("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml", :xml)
    #   # => '<xml></xml>'
    #
    # Returns a Fxchanger::Response.
    def self.get(endpoint, response_type)
      connection = Faraday.new endpoint do |conn|
        conn.response response_type

        conn.adapter Faraday.default_adapter
      end

      response = connection.get
      handle_response response
    end

    private

    # Convert a response from the HTTP library to a Fxchanger::Response.
    #
    # response  - The response to be wrapped.
    #
    # Returns a Fxchanger::Response.
    def self.handle_response(response)
      if response.success?
        Fxchanger::Response.new response
      end
    end
  end
end
