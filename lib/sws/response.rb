require 'delegate'
require 'multi_xml'

module SWS
  class Response < SimpleDelegator
    def to_h
      MultiXml.parse(body)
    end
  end
end
