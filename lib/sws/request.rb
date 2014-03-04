require 'uri'
require 'excon'
require 'sws/response'

# An Abebooks SWS API Request.
module SWS
  class Request
    attr_reader :api_base_url, :client_key

    # Create a new request for given locale.
    #
    # client_key - The String client_key of the API endpoint.
    def initialize(client_key)
      @client_key = client_key
      @api_base_url = 'http://search2.abebooks.com/search'
    end

    # Make a request to Abebooks SWS API
    #
    # search_arguments - The Hash search_arguments contains the arguments that will be used to query SWS API.
    #                    http://www.abebooks.com/docs/AffiliateProgram/WebServices/end-user-guide.pdf
    #
    # request_options - The Hash request_options has options for Excon
    #
    # Raises a MissingPrimaryArguments error none of the mandatory arguments are found
    def perform(search_arguments={}, request_options={})
      o = request_options.merge({
         expects: [200]
      })

      url = url(url_encode(search_arguments)).to_s
      res = Excon.get(url, o)

      Response.new(res)
    end

    # Build a URL.
    #
    # params - A Hash of Abebooks SWS API arguments.
    #
    # Returns the built URL String.
    def url(search_arguments)
      # Include client_key in the search arguments
      search_arguments['clientkey'] = client_key

      # Delete any nil or empty arguments
      search_arguments.delete_if do |k, v|
        !v || v.empty?
      end

      # If you send in 'new' (or similar variants) as book condition, it converts it to what the API
      # understands, which is 'newonly'
      search_arguments.each do |k, v|
        if k == 'bookcondition' && v.downcase == 'new'
          search_arguments[k] = 'newonly'
        end
      end

      URI("#{api_base_url}?#{URI.encode_www_form(search_arguments)}")
    end

    private

    def url_encode(search_arguments)
      search_arguments['author'] = URI(search_arguments['author']).to_s if search_arguments['author']
      search_arguments['title'] = URI(search_arguments['title']).to_s if search_arguments['title']

      search_arguments
    end
  end
end
