module Fxchanger
  # Public: The Harvester if responsible for collecting exchange data from a third party URL and saving that data into
  # the database.
  class Harvester
    # Public: Initialize a harvester.
    #
    # harvest_details - The Fxchanger::HarvestDetails containing information on the third party exchange.
    # db_string - The database String used to create a connection to the database.
    def initialize(
      harvest_details,
      database_string: Fxchanger.configuration.database_string,
      converter: Fxchanger::EcbSourceConverter.new
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
      response = Fxchanger::ExchangeRequest.get @harvest_details.endpoint, @harvest_details.content_type
      unless response.success?
        throw Fxchanger::ExchangeResponseError.new response
      end

      rates = converter.convert(response.body)

      repository = Fxchanger::ExchangeRepository.new @database_string
      repository.create_table?
      latest_date = repository.get_latest_date
      # Filter out any dates before the most recent import but leave in dates matching most recent
      # to prevent any rates from being missed if the exchange is updated after running the harvester.
      if latest_date == nil
        latest_rates = rates
      else
        latest_rates = filter_rates_older_than rates, latest_date
      end

      repository.save_many_rates latest_rates
    end

    private
    # Returns the HarvestDetails of the harvester.
    attr_reader :harvest_details
    # Returns the database connection String of the harvester.
    attr_reader :database_string
    # Returns the String database connection details of the harvester.
    attr_reader :converter

    # Filter out any rates that are before a given date.
    #
    # rates - The array of Rates.
    # date - The Date to filter with.
    def filter_rates_older_than(rates, date)
      rates.select {|rate| Date.parse(rate.date) >= date}
    end
  end
end
