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

    base_uri   API_URL

    headers    "User-Agent"      => "ruby-gem-picasa-v#{VERSION} (gzip)",
               "GData-Version"   => API_VERSION,
               "Content-Type"    => "application/atom+xml",
               "Accept-Encoding" => "gzip, deflate"

    http_proxy *proxy

    format     :xml
  end
end
