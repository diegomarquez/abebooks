require 'delegate'
require 'multi_xml'

module Abebooks
  # Parses the API response
  class Response < SimpleDelegator
    def to_h
      MultiXml.parse(body)
    end
  end
end
