require "net/http"
require "net/https"
require "uri"
require "multi_xml"

class Picasa::Client
  URL = "https://picasaweb.google.com"
  API_VERSION = "2"

  attr_accessor :user_id
  attr_reader :response, :parsed_body

  def initialize(user_id)
    self.user_id = user_id || Picasa.config.user_id
  end

  def http
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end

  def get(path, params = {})
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

  def uri
    URI.parse(URL)
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
    {"User-Agent" => "ruby-gem-v#{Picasa::VERSION}", "GData-Version" => API_VERSION}
  end
end
