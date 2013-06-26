require "httparty"
require "uri"

module Picasa
  class HTTP
    include HTTParty

    API_URL      = "https://picasaweb.google.com"
    API_AUTH_URL = "https://www.google.com"
    API_VERSION  = "2"

    def self.proxy
      proxy_uri = URI.parse(ENV["https_proxy"] || ENV["HTTPS_PROXY"] || "")
      [proxy_uri.host, proxy_uri.port, proxy_uri.user, proxy_uri.password]
    end

    format         :json
    default_params alt: :json

    headers        "User-Agent"      => "ruby-gem-picasa-v#{VERSION} (gzip)",
                   "GData-Version"   => API_VERSION,
                   "Accept-Encoding" => "gzip, deflate"

    base_uri       API_URL

    http_proxy     *proxy
  end
end
