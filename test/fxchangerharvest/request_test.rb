require "test_helper"

class RequestTest < Minitest::Test
  def test_request_get_xml
    endpoint = "http://test.test/test.xml"
    stub_request(:get, endpoint).
      to_return(body: "<xml></xml>")

    response = FxchangerHarvest::Request.get(endpoint, :xml)
    assert_kind_of FxchangerHarvest::Response, response
  end

  def test_request_get_json
    endpoint = "http://test.test/test.xml"
    stub_request(:get, endpoint).
        to_return(body: "{\"data\": \"data\"}")

    response = FxchangerHarvest::Request.get(endpoint, :json)
    assert_kind_of FxchangerHarvest::Response, response
  end
end
