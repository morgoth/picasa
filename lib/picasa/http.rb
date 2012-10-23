require 'httparty'
require 'uri'

module Picasa
  class HTTP
    API_URL      = "https://picasaweb.google.com"
    API_AUTH_URL = "https://www.google.com"
    API_VERSION  = "2"
    
    def self.proxy
      proxy_uri ||= URI.parse(ENV["https_proxy"] || ENV["HTTPS_PROXY"] || '')
      { :addr => proxy_uri.host,
        :port => proxy_uri.port,
        :user => proxy_uri.user,
        :pass => proxy_uri.password }
    end

    include HTTParty

    base_uri       API_URL

    headers        "User-Agent"      => "ruby-gem-picasa-v#{VERSION} (gzip)",
                   "GData-Version"   => API_VERSION,
                   "Content-Type"    => "application/atom+xml",
                   "Accept-Encoding" => "gzip, deflate"

    http_proxy     proxy[:addr], proxy[:port], proxy[:user], proxy[:pass]

    format  :xml
  end
end
