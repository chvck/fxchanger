require "test_helper"

class DataSourceConverterTest < Minitest::Test
  def test_convert
    data = {
      "Envelope" => {
        "xmlns:gesmes" => "http://www.gesmes.org/xml/2002-08-01",
        "xmlns" => "http://www.ecb.int/vocabulary/2002-08-01/eurofxref",
        "subject" => "Reference rates",
        "Sender" => {"name" => "European Central Bank"},
        "Cube" => {
          "Cube" => [
            {"time" => "2017-11-07",
             "Cube" => [
               {"currency" => "USD", "rate" => "1.1562"},
               {"currency" => "JPY", "rate" => "132.03"}
             ]}
          ]
        }
      }
    }
    converter = Fxchanger::DataSourceConverter.new
    converted = converter.convert data
    assert_equal data, converted
  end
end
