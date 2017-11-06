module FxchangerHarvest
  # Public: The Harvester if responsible for collecting exchange data from a third party URL and saving that data into
  # the database.
  class Harvester
    # Public: Initialize a harvester.
    #
    # harvest_details - The FxchangerHarvest::HarvestDetails containing information on the third party exchange.
    # db_string - The database String used to create a connection to the database.
    def initialize(
        harvest_details,
        database_string,
        converter = FxchangerHarvest::EcbSourceConverter.new
    )
      @harvest_details = harvest_details
      @database_string = database_string
      @converter = converter
    end

    # Public: Fetch data from third party and populate the database.
    #
    # Examples
    #
    #   prefetch!
    def prefetch!
      response = FxchangerHarvest::Request.get(@harvest_details.endpoint, @harvest_details.content_type)
      unless response.success?
        throw FxchangerHarvest::ResponseError.new(response)
      end

      rates = converter.convert(response.body)
      # puts rates
      repository = FxchangerHarvest::ExchangeRepository.new(@database_string)
      repository.create_table?
      repository.save_many rates
    end

    private
    # Returns the HarvestDetails of the harvester.
    attr_reader :harvest_details
    # Returns the database connection String of the harvester.
    attr_reader :database_string
    # Returns the String database connection details of the harvester.
    attr_reader :converter
  end
end
