require 'forwardable'
require 'abebooks/request'

# Wrapper to the Abebooks SWS API
module Abebooks
  class << self
    extend Forwardable

    def_delegator Request, :new
  end
end
