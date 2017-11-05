require "test_helper"

class HarvestDetailsTest < Minitest::Test
  def test_initialization_correctly_assigns_values
    endpoint = "http://test.endpoint"
    content_type = :xml
    harvester_details = FxchangerHarvest::HarvestDetails.new endpoint, content_type

    assert_equal endpoint, harvester_details.endpoint
    assert_equal content_type, harvester_details.content_type
  end
end
