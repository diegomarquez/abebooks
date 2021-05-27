# frozen_string_literal: true

require "delegate"
require "ox"

module Abebooks
  class Response < SimpleDelegator
    class HTTPStatus < StandardError; end

    def to_h
      raise HTTPStatus unless ok?

      Ox.load(to_s, mode: :hash, symbolize_keys: false)
    end

    def ok?
      code == 200
    end
  end
end
