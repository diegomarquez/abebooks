require 'excon'
require 'abebooks/response'

module Abebooks
  # Runs a search query
  class Request
    def initialize(client_key = ENV['ABEBOOKS_CLIENT_KEY'])
      @client_key = client_key
    end

    def get(opts)
      opts.fetch(:query).update('clientkey' => @client_key)
      Response.new(connection.get(opts))
    end

    private

    def connection
      Excon.new('http://search2.abebooks.com/search', expects: 200)
    end
  end
end
