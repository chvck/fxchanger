require "test_helper"

class FxchangerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Fxchanger::VERSION
  end
end
