# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/abebooks"

class TestAbebooks < Minitest::Test
  def test_ok
    skip unless ENV.key?("ABEBOOKS_CLIENT_KEY")

    request = Abebooks.new
    response = request.get(author: "Tolkien")

    assert response.ok?
    refute_empty response.to_h
  end

  def test_unauthorized
    request = Abebooks.new("foo")
    response = request.get

    refute response.ok?
    assert_raises { response.to_h }
  end
end
