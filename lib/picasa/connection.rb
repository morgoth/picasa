require "net/https"
require "uri"

module Picasa
  class Connection
    # @param [Hash] params request arguments
    # @option params [String] :host host of request
    # @option params [String] :path request path
    # @option params [String] :query request url query
    # @option params [String] :headers request headers
    def get(params = {})
      params[:host]    ||= API_URL
      params[:headers] ||= {}
      params[:query]   ||= {}

      path = path_with_query(params[:path], params[:query])
      request = Net::HTTP::Get.new(path, headers.merge(params[:headers]))
      handle_response(http(params[:host]).request(request))
    end

    # @param [Hash] params request arguments
    # @option params [String] :host host of request
    # @option params [String] :path request path
    # @option params [String] :body request body (for POST)
    # @option params [String] :query request url query
    # @option params [String] :headers request headers
    def post(params = {})
      params[:host]    ||= API_URL
      params[:headers] ||= {}

      request = Net::HTTP::Post.new(params[:path], headers.merge(params[:headers]))
      request.body = params[:body]
      handle_response(http(params[:host]).request(request))
    end

    # @param [Hash] params request arguments
    # @option params [String] :host host of request
    # @option params [String] :path request path
    # @option params [String] :query request url query
    # @option params [String] :headers request headers
    def delete(params = {})
      params[:host]    ||= API_URL
      params[:headers] ||= {}

      request = Net::HTTP::Delete.new(params[:path], headers.merge(params[:headers]))
      handle_response(http(params[:host]).request(request))
    end

    def path_with_query(path, query = {})
      path = path + "?" + Utils.inline_query(query) unless query.empty?
      URI.parse(path).to_s
    end

    private

    def http(url = API_URL)
      uri = URI.parse(url)
      proxy = URI(ENV['https_proxy'] || ENV['http_proxy'] || '')
      http = Net::HTTP::Proxy(proxy.host, proxy.port).new(uri.host, uri.port)
      http.use_ssl = true
      http
    end

    def handle_response(response)
      case response.code.to_i
      when 200...300
        response
      when 403
        raise ForbiddenError.new(response.body, response)
      when 404
        raise NotFoundError.new(response.body, response)
      when 412
        raise PreconditionFailedError.new(response.body, response)
      else
        raise ResponseError.new(response.body, response)
      end
    end

    def headers
      {
        "User-Agent"    => "ruby-gem-v#{VERSION}",
        "GData-Version" => API_VERSION,
        "Content-Type"  => "application/atom+xml"
      }
    end
  end
end
