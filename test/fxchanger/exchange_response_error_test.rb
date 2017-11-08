require "test_helper"

class ExchangeResponseErrorTest < Minitest::Test
  def test_formatted_message
    code = 401
    message = "unauthorized"
    mock_response = Minitest::Mock.new
    mock_response.expect :status_code, code
    mock_response.expect :error_message, message


    error = Fxchanger::ExchangeResponseError.new mock_response
    assert "#{message} (#{code})", error.formatted_message
  end
end
