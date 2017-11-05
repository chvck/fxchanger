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
        db_string
    )
      @harvest_details = harvest_details
      @db_string = db_string
    end

    # Public: Fetch data from third party and populate the database.
    #
    # Examples
    #
    #   prefetch()
    def prefetch
      response = FxchangerHarvest::Request.get(@harvest_details.endpoint, @harvest_details.content_type)
    end

    private
    # Returns the HarvestDetails of the harvester.
    attr_reader :harvest_details
    # Returns the String database connection details of the harvester.
    attr_reader :db_string
  end
end
