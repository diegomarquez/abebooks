require 'forwardable'
require 'sws/request'
require 'sws/version'

# A Wrapper for Abebooks SWS API
module SWS
  class << self
    extend Forwardable

    def_delegator SWS::Request, :new
  end
end
