require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

require 'dotenv'
Dotenv.load

require_relative '../lib/abebooksSWS'

class TestAbebooksSWS < Minitest::Unit::TestCase
  include AbebooksSWS

  def test_requires_client_key_in_credentials
    assert_raises(Request::MissingClientKey) do
      Request.new
    end
  end

  def test_returns_url
    req = Request.new({
      clientkey: 'sws_client_key'
    })

    url = req.url({'Foo' => 'Bar'})

    assert_match(/#{req.api_base_url}?/, url.to_s)
    assert_match(/clientkey=sws_client_key/, url.query)
    assert_match(/Foo=Bar/, url.query)
  end

  def test_fetches_parsable_response
    Excon.stub({}, { body: '<foo>bar</foo>' })

    req = Request.new({
      clientkey: 'sws_client_key'
    })

    res = req.perform({'isbn' => '666666666'}, mock: true)
    refute_empty res.to_h
    Excon.stubs.clear
  end

  def test_raises_error_if_primary_arguments_are_missing
    req = Request.new({
      clientkey: 'sws_client_key'
    })

    assert_raises(Request::MissingPrimaryArguments) do
      req.perform
    end
  end

  def test_nil_and_empty_strings_are_removed_from_the_final_query
    req = Request.new({
      clientkey: 'sws_client_key'
    })

    url = req.url({
      'Foo' => 'Bar',
      'Nil' => nil,
      'EmptyString' => '',
    })

    assert_match(/Foo=Bar/, url.query)
    refute_match(/Nil=/, url.query)
    refute_match(/EmptyString=/, url.query)
  end

  def test_converts_new_bookcondition_search_argument
    req = Request.new({
      clientkey: 'sws_client_key'
    })

    url = req.url({
      'bookcondition' => 'New',
    })

    assert_match(/bookcondition=newonly/, url.query)
  end

  def test_offer_urls_domain_is_converted
    req = Request.new({
      clientkey: ENV['CLIENT_KEY']
    })

    res = req.perform({'isbn' => '0451161351'})

    results = res.convert_offer_urls('www.abebooks.de')

    results['searchResults']['Book'].each do |book|
      assert_match /www\.abebooks\.de/, book['listingUrl']
    end
  end
end
