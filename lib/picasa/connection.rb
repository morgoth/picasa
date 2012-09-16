require "net/https"
require "cgi"
require "uri"

module Picasa
  class Connection
    attr_reader :user_id, :password

    def initialize(credentials = {})
      @user_id  = credentials.fetch(:user_id)
      @password = credentials.fetch(:password, nil)
    end

    def http(url = API_URL)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http
    end

    # @param [Hash] params request arguments
    # @option params [String] :path request path
    # @option params [String] :body request body (for POST)
    # @option params [String] :query request url query
    # @option params [String] :headers request headers
    def get(params = {})
      params[:headers] ||= {}
      params[:query] ||= {}
      authenticate if auth?

      path = path_with_query(params[:path], params[:query])
      request = Net::HTTP::Get.new(path, headers.merge(params[:headers]))
      handle_response(http.request(request))
    end

    def post(params = {})
      params[:headers] ||= {}
      authenticate if auth?

      request = Net::HTTP::Post.new(params[:path], headers.merge(params[:headers]))
      request.body = params[:body]
      handle_response(http.request(request))
    end

    def delete(params = {})
      params[:headers] ||= {}
      authenticate if auth?

      request = Net::HTTP::Delete.new(params[:path], headers.merge(params[:headers]))
      handle_response(http.request(request))
    end

    def inline_query(query)
      query.map do |key, value|
        dasherized = key.to_s.gsub("_", "-")
        "#{CGI.escape(dasherized)}=#{CGI.escape(value.to_s)}"
      end.join("&")
    end

    def path_with_query(path, query = {})
      path = path + "?" + inline_query(query) unless query.empty?
      URI.parse(path).to_s
    end

    private

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
        "User-Agent"    => client_name,
        "GData-Version" => API_VERSION,
        "Content-Type"  => "application/atom+xml"
      }.tap do |headers|
        headers["Authorization"] = "GoogleLogin auth=#{@auth_key}" if @auth_key
      end
    end

    def auth?
      !password.nil?
    end

    def authenticate
      data = inline_query({"accountType" => "HOSTED_OR_GOOGLE",
                            "Email"       => user_id,
                            "Passwd"      => password,
                            "service"     => "lh2",
                            "source"      => client_name})

      response = handle_response(http(API_AUTH_URL).post("/accounts/ClientLogin", data))

      @auth_key = extract_auth_key(response.body)
    end

    def extract_auth_key(data)
      response = data.split("\n").map { |v| v.split("=") }
      params = Hash[response]
      params["Auth"]
    end

    def client_name
      "ruby-gem-v#{Picasa::VERSION}"
    end
  end
end
