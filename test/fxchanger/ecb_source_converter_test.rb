require "test_helper"

class EcbSourceConverterTest < Minitest::Test
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
    expected = [
      Fxchanger::Rate.new(1.1562, "USD", "2017-11-07", "European Central Bank"),
      Fxchanger::Rate.new(132.03, "JPY", "2017-11-07", "European Central Bank"),
      Fxchanger::Rate.new(1.0, "EUR", "2017-11-07", "European Central Bank")
    ]

    converter = Fxchanger::EcbSourceConverter.new
    converted = converter.convert data
    assert_equal 3, converted.length
    assert_includes converted, expected[0]
    assert_includes converted, expected[1]
    assert_includes converted, expected[2]
  end
end
