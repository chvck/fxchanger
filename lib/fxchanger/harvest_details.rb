module Fxchanger
  # Public: Object responsible for containing the information required for a Harvester to connect and obtain data from a
  # third party.
  class HarvestDetails

    # Public: Returns the String value of the third party exchange address.
    attr_reader :endpoint
    # Public: Returns the Symbol value of the content type of the third party data.
    attr_reader :content_type

    # Public: Initialize a HarvestDetails object.
    #
    # endpoint - The String containing the address of the third party exchange.
    # content_type - The Symbol representing the format of the third party data.
    def initialize(endpoint, content_type = :xml)
      @endpoint = endpoint
      @content_type = content_type.to_sym
    end

  end
end
