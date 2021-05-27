# frozen_string_literal: true

require "forwardable"
require "abebooks/request"

module Abebooks
  class << self
    extend Forwardable

    def_delegator Request, :new
  end
end
