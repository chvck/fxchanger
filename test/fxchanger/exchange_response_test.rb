require "test_helper"

class ExchangeResponseTest < Minitest::Test
  def test_success?
    mock_response = Minitest::Mock.new
    mock_response.expect :success?, true

    response = Fxchanger::ExchangeResponse.new mock_response
    assert true, response.success?
  end

  def test_status_code
    mock_response = Minitest::Mock.new
    mock_response.expect :status, 200

    response = Fxchanger::ExchangeResponse.new mock_response
    assert 200, response.status_code
  end

  def test_error_message
    error = "error"
    mock_response = Minitest::Mock.new
    mock_response.expect :reason_phrase, error

    response = Fxchanger::ExchangeResponse.new mock_response
    assert error, response.error_message
  end

  def test_body
    body = "body"
    mock_response = Minitest::Mock.new
    mock_response.expect :body, body

    response = Fxchanger::ExchangeResponse.new mock_response
    assert body, response.body
  end
end
