# frozen_string_literal: true

require "http"
require "abebooks/response"

module Abebooks
  class Request
    URL = "https://search2.abebooks.com/search"

    def initialize(client_key = ENV["ABEBOOKS_CLIENT_KEY"])
      @client_key = client_key
    end

    def get(parameters = {})
      response = HTTP.use(:auto_inflate)
        .headers("Accept-Encoding" => "gzip")
        .get(URL, params: parameters.merge("clientkey" => @client_key))

      Response.new(response)
    end
  end
end
