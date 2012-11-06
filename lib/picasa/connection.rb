module Picasa
  class Connection
    # @param [Hash] params request arguments
    # @option params [String] :host host of request
    # @option params [String] :path request path
    # @option params [String] :query request url query
    # @option params [String] :headers request headers
    def get(params = {})
      # FIXME: how to add headers to default ones instead of replacing?
      params[:headers] = Picasa::HTTP.headers.merge(params[:headers]) if params.has_key?(:headers)
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
      params[:headers] = Picasa::HTTP.headers.merge(params[:headers])
      exec_request(params) { |uri, options| HTTP.post(uri, options) }
    end

    # @param [Hash] params request arguments
    # @option params [String] :host host of request
    # @option params [String] :path request path
    # @option params [String] :query request url query
    # @option params [String] :headers request headers
    def delete(params = {})
      params[:headers] = Picasa::HTTP.headers.merge(params[:headers]) if params.has_key?(:headers)
      exec_request(params) { |uri, options| HTTP.delete(uri, options) }
    end

    private

    def exec_request(params, &block)
      uri = "#{params.delete(:host)}#{params.delete(:path)}"
      params.delete_if { |key, value| value.nil? || value.empty? }
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
  end
end
