require "net/https"
require "uri"

module Picasa
  class Connection
    attr_reader :user_id, :password, :response

    def initialize(credentials = {})
      @user_id  = credentials.fetch(:user_id)
      @password = credentials.fetch(:password, nil)
    end

    def http(url = API_URL)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def get(path, params = {})
      authenticate if auth?

      path = path_with_params(path, params)
      request = Net::HTTP::Get.new(path, headers)
      @response = http.request(request)
      parsed_body
    end

    def parsed_body
      @parsed_body ||= MultiXml.parse(response.body)
    end

    def inline_params(params)
      params.map do |param, value|
        param = param.to_s.gsub("_", "-")
        "#{param}=#{value}"
      end.join("&")
    end

    def path_with_params(path, params = {})
      path = path + "?" + inline_params(params) unless params.empty?
      URI.parse(path).to_s
    end

    private

    def headers
      {"User-Agent" => "ruby-gem-v#{Picasa::VERSION}", "GData-Version" => API_VERSION}.tap do |headers|
        headers["Authorization"] = "GoogleLogin auth=#{@auth_key}" if @auth_key
      end
    end

    def auth?
      !password.nil?
    end

    def validate_email!
      unless user_id =~ /[a-z0-9][a-z0-9._%+-]+[a-z0-9]@[a-z0-9][a-z0-9.-][a-z0-9]+\.[a-z]{2,6}/i
        raise ArgumentError.new("user_id must be a valid E-mail address when authentication is used.")
      end
    end

    def authenticate
      return @auth_key if defined?(@auth_key)
      validate_email!

      data = inline_params({"accountType" => "HOSTED_OR_GOOGLE",
                            "Email"       => user_id,
                            "Passwd"      => password,
                            "service"     => "lh2",
                            "source"      => "ruby-gem-v#{Picasa::VERSION}"})

      response = http(API_AUTH_URL).post("/accounts/ClientLogin", data)
      raise ResponseError.new(response.body, response) unless response.is_a? Net::HTTPSuccess

      @auth_key = extract_auth_key(response.body)
    end

    def extract_auth_key(data)
      response = data.split("\n").map { |v| v.split("=") }
      response = Hash[*response.collect { |v| [v, v * 2] }.flatten]
      response["Auth"]
    end
  end
end
