require "net/http"
require "net/https"
require "uri"

class Picasa::Client
  URL = "https://picasaweb.google.com"
  API_VERSION = "2"

  attr_accessor :username
  attr_reader :response

  def initialize(username)
    self.username = username
  end

  def http
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end

  def get(path)
    request = Net::HTTP::Get.new(path, headers)
    @response = http.request(request)
    self
  end

  def uri
    URI.parse(URL)
  end

  private

  def headers
    {"User-Agent" => "ruby-gem-v#{Picasa::VERSION}", "GData-Version" => API_VERSION}
  end
end
