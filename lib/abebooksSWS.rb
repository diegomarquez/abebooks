require 'forwardable'
require 'abebooksSWS/request'
require 'abebooksSWS/version'

# A Wrapper for Abebooks SWS API
module AbebooksSWS
  class << self
    extend Forwardable

    def_delegator AbebooksSWS::Request, :new
  end
end
