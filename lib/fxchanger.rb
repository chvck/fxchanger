require "faraday"
require "faraday_middleware"
require "sequel"
require "gem_config"

require_relative "fxchanger/version"
require_relative "fxchanger/data_source_converter"
require_relative "fxchanger/ecb_source_converter"
require_relative "fxchanger/exchange_repository"
require_relative "fxchanger/harvest_details"
require_relative "fxchanger/harvester"
require_relative "fxchanger/rate"
require_relative "fxchanger/exchange_request"
require_relative "fxchanger/rate"
require_relative "fxchanger/exchange_response"
require_relative "fxchanger/exchange_response_error"
require_relative "fxchanger/exchange_rate"
require_relative "fxchanger/exchange_rate_error"
require_relative "fxchanger/exchange_converter"

module Fxchanger
  include GemConfig::Base

  with_configuration do
    has :database_string
  end

end
