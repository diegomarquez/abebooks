require 'delegate'
require 'multi_xml'

module AbebooksSWS
  class Response < SimpleDelegator
    def to_h
      MultiXml.parse(body)
    end

    def convert_offer_urls(domain)
      results = to_h

      results['searchResults']['Book'].each do |book|
        book['listingUrl'].gsub!(/www\.abebooks\.com/, domain)
      end

      results
    end
  end
end
