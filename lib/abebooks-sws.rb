require 'forwardable'
require 'abebooks-sws/request'
require 'abebooks-sws/version'

# A Wrapper for Abebooks SWS API
module Abebooks
  module SWS
    class << self
      extend Forwardable

      def_delegator Abebooks::SWS::Request, :new
    end
  end
end
