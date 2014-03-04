require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/abebooks-sws'

class TestSWS < Minitest::Unit::TestCase
  include SWS

  def test_returns_url
    req = Request.new('sws_client_key')

    url = req.url({'Foo' => 'Bar'})

    assert_match(/#{req.api_base_url}?/, url.to_s)
    assert_match(/clientkey=sws_client_key/, url.query)
    assert_match(/Foo=Bar/, url.query)
  end

  def test_fetches_parsable_response
    Excon.stub({}, { body: '<foo>bar</foo>' })

    req = Request.new('sws_client_key')

    res = req.perform({'isbn' => '666666666'}, mock: true)
    refute_empty res.to_h
    Excon.stubs.clear
  end

  def test_nil_and_empty_strings_are_removed_from_the_final_query
    req = Request.new(clientkey: 'sws_client_key')

    url = req.url({
      'Foo' => 'Bar',
      'Nil' => nil,
      'EmptyString' => ''
    })

    assert_match(/Foo=Bar/, url.query)
    refute_match(/Nil=/, url.query)
    refute_match(/EmptyString=/, url.query)
  end

  def test_converts_new_bookcondition_search_argument
    req = Request.new('sws_client_key')
    url = req.url({ 'bookcondition' => 'New' })
    assert_match(/bookcondition=newonly/, url.query)
  end
end
