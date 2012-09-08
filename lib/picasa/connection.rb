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
	  # ruby 1.9.3 => error SSL certificate
	  # maybe, Google has issued an invalid certificate.
	  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def get(path, params = {})
      authenticate if auth?

      path = path_with_params(path, params)
      request = Net::HTTP::Get.new(path, headers)
      response = handle_response(http.request(request))
      MultiXml.parse(response.body)
    end

    def post(path, body, custom_headers = {})
      authenticate if auth?

      request = Net::HTTP::Post.new(path, headers.merge(custom_headers))
      request.body = body
      response = handle_response(http.request(request))
      MultiXml.parse(response.body)
    end

    def delete(path, custom_headers = {})
      authenticate if auth?

      request = Net::HTTP::Delete.new(path, headers.merge(custom_headers))
      handle_response(http.request(request))
    end

    def inline_params(params)
      params.map do |key, value|
        dasherized = key.to_s.gsub("_", "-")
        "#{CGI.escape(dasherized)}=#{CGI.escape(value.to_s)}"
      end.join("&")
    end

    def path_with_params(path, params = {})
      path = path + "?" + inline_params(params) unless params.empty?
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
      data = inline_params({"accountType" => "HOSTED_OR_GOOGLE",
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
