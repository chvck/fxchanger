require "test_helper"

class RateTest < Minitest::Test
  def test_initialization_assigns_value_correctly
    exchange_rate = 3.141
    currency = "GBP"
    date = "2017-11-02"
    provider = "European Central Bank"

    rate = Fxchanger::Rate.new exchange_rate, currency, date, provider
    assert_equal exchange_rate, rate.rate
    assert_equal currency, rate.currency
    assert_equal date, rate.date
    assert_equal provider, rate.provider
  end

  def test_time_as_timestamp_string
    exchange_rate = 3.141
    currency = "GBP"
    date = "2017-11-02"
    provider = "European Central Bank"

    rate = Fxchanger::Rate.new exchange_rate, currency, date, provider
    assert_equal 1509580800, rate.time_as_timestamp
  end

  def test_time_as_timestamp_bignum
    exchange_rate = 3.141
    currency = "GBP"
    date = 1509580800
    provider = "European Central Bank"

    rate = Fxchanger::Rate.new exchange_rate, currency, date, provider
    assert_equal 1509580800, rate.time_as_timestamp
  end
end
