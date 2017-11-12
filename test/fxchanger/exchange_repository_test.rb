require "test_helper"

class ExchangeRepositoryTest < Minitest::Test
  DB_STRING = "sqlite::memory:"
  DB = Sequel.connect(DB_STRING)

  def teardown
    DB.drop_table? :rates
  end

  def test_create_table?
    repository = Fxchanger::ExchangeRepository.new DB_STRING
    repository.set_connection DB
    repository.create_table?
    assert_equal true, DB.table_exists?(:rates)
  end

  def test_create_table_doesnt_drop?
    repository = Fxchanger::ExchangeRepository.new DB_STRING
    repository.set_connection DB
    repository.create_table?
    assert_equal true, DB.table_exists?(:rates)
    DB[:rates].insert({:rate => 3.141, :currency => "GBP", :provider => "European Central Bank", :date => 1509580800})
    repository.create_table?
    assert_equal 1, DB[:rates].count
  end

  def test_get_latest_date
    repository = Fxchanger::ExchangeRepository.new DB_STRING
    repository.set_connection DB
    repository.create_table?
    expected_rate = {:rate => 32.2, :currency => "GBP", :provider => "European Central Bank", :date => 1509753600}
    DB[:rates].insert({:rate => 3.141, :currency => "GBP", :provider => "European Central Bank", :date => 1509580800})
    DB[:rates].insert({:rate => 1.12, :currency => "GBP", :provider => "European Central Bank", :date => 1509667200})
    DB[:rates].insert({:rate => 0.88, :currency => "RON", :provider => "European Central Bank", :date => 1509580800})
    DB[:rates].insert(expected_rate)

    actual_date = repository.get_latest_date
    assert_equal Date.parse(Time.at(expected_rate[:date]).to_s), actual_date
  end

  def test_save_many
    repository = Fxchanger::ExchangeRepository.new DB_STRING
    repository.set_connection DB
    repository.create_table?
    rates = [
      Fxchanger::Rate.new(32.2, "GBP", 1509753600, "European Central Bank"),
      Fxchanger::Rate.new(3.141, "GBP", 1509580800, "European Central Bank"),
      Fxchanger::Rate.new(1.12, "GBP", 1509667200, "European Central Bank"),
      Fxchanger::Rate.new(0.88, "RON", 1509580800, "European Central Bank")
    ]

    repository.save_many_rates(rates)
    # This could do with being expanded upon
    assert_equal 4, DB[:rates].count
  end

  def test_save_many_update
    repository = Fxchanger::ExchangeRepository.new DB_STRING
    repository.set_connection DB
    repository.create_table?
    DB[:rates].insert({:rate => 3.141, :currency => "GBP", :provider => "European Central Bank", :date => 1509580800})
    rates = [
      Fxchanger::Rate.new(32.2, "GBP", 1509753600, "European Central Bank"),
      Fxchanger::Rate.new(7.8, "GBP", 1509580800, "European Central Bank")
    ]

    repository.save_many_rates(rates)
    actual_rate = DB[:rates].where(currency: "GBP", provider: "European Central Bank", date: 1509580800)
                    .select(:rate).first
    assert_equal 2, DB[:rates].count
    assert_equal 7.8, actual_rate[:rate]
  end

  def test_get_rate_at
    repository = Fxchanger::ExchangeRepository.new DB_STRING
    repository.set_connection DB
    repository.create_table?
    expected_rate = {:rate => 32.2, :currency => "GBP", :provider => "European Central Bank", :date => 1509753600}
    DB[:rates].insert({:rate => 3.141, :currency => "GBP", :provider => "European Central Bank", :date => 1509580800})
    DB[:rates].insert({:rate => 1.12, :currency => "GBP", :provider => "European Central Bank", :date => 1509667200})
    DB[:rates].insert({:rate => 0.88, :currency => "RON", :provider => "European Central Bank", :date => 1509580800})
    DB[:rates].insert(expected_rate)

    actual_rate = repository.get_rate_at Date.parse(Time.at(expected_rate[:date]).to_s), expected_rate[:currency]
    assert_equal expected_rate[:rate], actual_rate
  end

  def test_get_rate_at_string
    repository = Fxchanger::ExchangeRepository.new DB_STRING
    repository.set_connection DB
    repository.create_table?
    expected_rate = {:rate => 32.2, :currency => "GBP", :provider => "European Central Bank", :date => 1509753600}
    DB[:rates].insert({:rate => 3.141, :currency => "GBP", :provider => "European Central Bank", :date => 1509580800})
    DB[:rates].insert({:rate => 1.12, :currency => "GBP", :provider => "European Central Bank", :date => 1509667200})
    DB[:rates].insert({:rate => 0.88, :currency => "RON", :provider => "European Central Bank", :date => 1509580800})
    DB[:rates].insert(expected_rate)

    actual_rate = repository.get_rate_at Date.parse(Time.at(expected_rate[:date]).to_s).to_s, expected_rate[:currency]
    assert_equal expected_rate[:rate], actual_rate
  end

  def test_currencies
    repository = Fxchanger::ExchangeRepository.new DB_STRING
    repository.set_connection DB
    repository.create_table?
    DB[:rates].insert({:rate => 3.141, :currency => "HUF", :provider => "European Central Bank", :date => 1509580800})
    DB[:rates].insert({:rate => 1.12, :currency => "GBP", :provider => "European Central Bank", :date => 1509667200})
    DB[:rates].insert({:rate => 0.88, :currency => "RON", :provider => "European Central Bank", :date => 1509580800})
    DB[:rates].insert({:rate => 32.2, :currency => "GBP", :provider => "European Central Bank", :date => 1509753600})

    currencies = repository.currencies
    assert_equal 3, currencies.count
    assert_includes currencies, "GBP"
    assert_includes currencies, "HUF"
    assert_includes currencies, "RON"
  end
end
