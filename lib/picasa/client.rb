require "net/http"
require "net/https"
require "uri"
require "multi_xml"

module Picasa
  class Client
    URL         = "https://picasaweb.google.com"
    AUTH_URL    = "https://www.google.com"
    API_VERSION = "2"

    attr_accessor :user_id
    attr_writer :password
    attr_reader :response, :parsed_body

    def initialize(user_id, password = nil)
      self.user_id  = user_id || Picasa.user_id
      @password     = password || Picasa.password
    end

    def http(url = URL)
      host, port = uri(url).host, uri(url).port
      http = Net::HTTP.new(host, port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def get(path, params = {})
      authenticate if auth?

      path = path_with_params(path, params)
      request = Net::HTTP::Get.new(path, headers)
      handle_response(http.request(request))
    end

    def response=(response)
      @response = response
      parse_response
    end

    def parse_response
      @parsed_body = MultiXml.parse(response.body)
    end

    def uri(url)
      URI.parse(url)
    end

    def handle_response(response)
      self.response = response
      parsed_body
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
      h = {"User-Agent" => "ruby-gem-v#{Picasa::VERSION}", "GData-Version" => API_VERSION}
      h["Authorization"] = "GoogleLogin auth=#{@auth_key}" unless @auth_key.nil?
      h
    end

    def auth?
      !@password.nil?
    end

    def validate_email!
      unless user_id =~ /[a-z0-9][a-z0-9._%+-]+[a-z0-9]@[a-z0-9][a-z0-9.-][a-z0-9]+\.[a-z]{2,6}/i
        raise ::ArgumentError.new("user_id must be a valid E-mail address when authentication is used.")
      end
    end

    def authenticate
      return @auth_key if @auth_key
      validate_email!

      data = inline_params({"accountType" => "HOSTED_OR_GOOGLE",
                                "Email"       => user_id,
                                "Passwd"      => @password,
                                "service"     => "lh2",
                                "source"      => "ruby-gem-v#{Picasa::VERSION}"})

      resp, data = http(AUTH_URL).post("/accounts/ClientLogin", data, headers)
      raise ::ArgumentError.new(resp) unless resp.is_a? Net::HTTPSuccess

      @auth_key = extract_auth_key(data)
    end

    def extract_auth_key(data)
      response = data.split("\n").map {|v| v.split "="}
      response = Hash[*response.collect { |v| [v, v*2] }.flatten]
      response["Auth"]
    end
  end
end
