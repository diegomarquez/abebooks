require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/abebooks'

class TestAbebooks < Minitest::Unit::TestCase
  def setup
    Excon.defaults[:mock] = true
    Excon.stub({}, { body: '<foo>bar</foo>' })
  end

  def teardown
    Excon.stubs.clear
  end

  def test_fetches_parsable_response
    req = Abebooks::Request.new
    res = req.get(query: {})
    refute_empty res.to_h
  end
end
