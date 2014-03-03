require 'uri'
require 'excon'
require 'abebooksSWS/response'

module AbebooksSWS
  # An Abebooks SWS API Request.
  class Request
    MissingClientKey  = Class.new(ArgumentError)
    MissingPrimaryArguments  = Class.new(ArgumentError)

    attr_reader :api_base_url, :credentials

    # Create a new request for given locale.
    #
    # credentials - The Hash credentials of the API endpoint.
    #               :client_key     - The String SWS client key.
    #
    # Raises a MissingClientKey error if no credentials are given
    def initialize(credentials={})
      raise MissingClientKey unless credentials[:clientkey]

      @credentials = credentials;
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
      raise MissingPrimaryArguments unless primary_arguments?(search_arguments)

      o = request_options.merge({
         expects: [200]
      })

      url = url(url_encode(search_arguments)).to_s
      res = Excon.get(url, o);

      Response.new(res);
    end

    # Build a URL.
    #
    # params - A Hash of Abebooks SWS API arguments.
    #
    # Returns the built URL String.
    def url(search_arguments)
      # Include credentials in the search arguments
      credentials.each do |key, val|
        search_arguments[key] = val
      end

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

    def primary_arguments?(search_arguments)
      search_arguments['isbn'] ||
      search_arguments['author'] ||
      search_arguments['title'] ||
      search_arguments['keyword'] ||
      search_arguments['pubname']
    end

    def url_encode(search_arguments)
      search_arguments['author'] = URI(search_arguments['author']).to_s if search_arguments['author']
      search_arguments['title'] = URI(search_arguments['title']).to_s if search_arguments['title']

      search_arguments
    end
  end
end
