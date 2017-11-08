require "test_helper"

class ExchangeConverterTest < Minitest::Test
  def test_at
    date = Date.parse("2017-11-07")
    base = "GBP"
    other = "HUF"

    base_rate = 3.141
    other_rate = 0.98

    mock = MiniTest::Mock.new
    mock.expect :get_rate_at, base_rate, [date, base]
    mock.expect :get_rate_at, other_rate, [date, other]

    exchanger = Fxchanger::ExchangeConverter.new mock
    conversion_rate = exchanger.at(date, base, other)

    assert_equal other_rate / base_rate, conversion_rate
  end

  def test_at_saturday
    date = Date.parse("2017-11-04")
    date_friday = Date.parse("2017-11-03")
    base = "GBP"
    other = "HUF"

    base_rate = 3.141
    other_rate = 0.98

    mock = MiniTest::Mock.new
    mock.expect :get_rate_at, base_rate, [date_friday, base]
    mock.expect :get_rate_at, other_rate, [date_friday, other]

    exchanger = Fxchanger::ExchangeConverter.new mock
    conversion_rate = exchanger.at(date, base, other)

    assert_equal other_rate / base_rate, conversion_rate
  end

  def test_at_sunday
    date = Date.parse("2017-11-05")
    date_friday = Date.parse("2017-11-03")
    base = "GBP"
    other = "HUF"

    base_rate = 3.141
    other_rate = 0.98

    mock = MiniTest::Mock.new
    mock.expect :get_rate_at, base_rate, [date_friday, base]
    mock.expect :get_rate_at, other_rate, [date_friday, other]

    exchanger = Fxchanger::ExchangeConverter.new mock
    conversion_rate = exchanger.at(date, base, other)

    assert_equal other_rate / base_rate, conversion_rate
  end

  def test_at_invalid_date
    date = Date.parse("2017-11-07")
    base = "GBP"
    other = "HUF"

    mock = MiniTest::Mock.new
    mock.expect :get_rate_at, nil, [date, base]
    mock.expect :get_rate_at, nil, [date, other]

    exchanger = Fxchanger::ExchangeConverter.new mock
    assert_raises Fxchanger::ExchangeRateError do
      exchanger.at(date, base, other)
    end

    def test_at_invalid_base_currency
      date = Date.parse("2017-11-07")
      base = "GBP"
      other = "HUF"

      mock = MiniTest::Mock.new
      mock.expect :get_rate_at, nil, [date, base]
      mock.expect :get_rate_at, 3.141, [date, other]

      exchanger = Fxchanger::ExchangeConverter.new mock
      assert_raises Fxchanger::ExchangeRateError do
        exchanger.at(date, base, other)
      end
    end

    def test_at_invalid_other_currency
      date = Date.parse("2017-11-07")
      base = "GBP"
      other = "HUF"

      mock = MiniTest::Mock.new
      mock.expect :get_rate_at, 3.141, [date, base]
      mock.expect :get_rate_at, nil, [date, other]

      exchanger = Fxchanger::ExchangeConverter.new mock
      assert_raises Fxchanger::ExchangeRateError do
        exchanger.at(date, base, other)
      end
    end
  end
end
