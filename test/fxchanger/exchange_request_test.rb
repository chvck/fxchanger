require "test_helper"

class ExchangeRequestTest < Minitest::Test
  def test_request_get_xml
    endpoint = "http://test.test/test.xml"
    stub_request(:get, endpoint).
        to_return(body: "<xml>test</xml>")

    response = Fxchanger::ExchangeRequest.get(endpoint, :xml)
    assert_kind_of Fxchanger::ExchangeResponse, response
    assert_equal({"xml" => "test"}, response.body)
  end

  def test_request_get_json
    endpoint = "http://test.test/test.xml"
    stub_request(:get, endpoint).
        to_return(body: "{\"data\": \"dataval\"}")

    response = Fxchanger::ExchangeRequest.get(endpoint, :json)

    assert_kind_of Fxchanger::ExchangeResponse, response
    assert_equal({"data" => "dataval"}, response.body)
  end
end
