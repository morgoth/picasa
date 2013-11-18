module Picasa
  class Connection
    # @param [Hash] params request arguments
    # @option params [String] :host host of request
    # @option params [String] :path request path
    # @option params [String] :query request url query
    # @option params [String] :headers request headers
    def get(params = {})
      exec_request(params) { |uri, options| HTTP.get(uri, options) }
    end

    # @param [Hash] params request arguments
    # @option params [String] :host host of request
    # @option params [String] :path request path
    # @option params [String] :body request body (for POST)
    # @option params [String] :query request url query
    # @option params [String] :headers request headers
    def post(params = {})
      params[:headers] ||= {}
      params[:headers]["Content-Type"] ||= "application/atom+xml"
      exec_request(params) { |uri, options| HTTP.post(uri, options) }
    end

    # @param [Hash] params request arguments
    # @option params [String] :host host of request
    # @option params [String] :path request path
    # @option params [String] :query request url query
    # @option params [String] :headers request headers
    def delete(params = {})
      exec_request(params) { |uri, options| HTTP.delete(uri, options) }
    end

    private

    # Additional params for HTTParty gem can be passed
    # https://github.com/jnunemaker/httparty/blob/v0.12.0/lib/httparty.rb#L43
    def exec_request(params, &block)
      uri = "#{params.delete(:host)}#{params.delete(:path)}"

      params.tap do |p|
        p[:headers] = HTTP.headers.merge(p.fetch(:headers, {}))
        if p.keys.none? { |name| [:http_proxyaddr, :http_proxyport, :http_proxyuser, :http_proxypass].include?(name) }
          p[:http_proxyaddr] = proxy_uri.host
          p[:http_proxyport] = proxy_uri.port
          p[:http_proxyuser] = proxy_uri.user
          p[:http_proxypass] = proxy_uri.password
        end
      end

      handle_response(yield(uri, params))
    end

    def handle_response(response)
      case response.code.to_i
      when 200...300
        response
      when 400
        raise BadRequestError.new(response.body, response)
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

    def proxy_uri
      @proxy_uri ||= URI.parse(ENV["https_proxy"] || ENV["HTTPS_PROXY"] || "")
    end
  end
end
