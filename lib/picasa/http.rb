require "httparty"
require "uri"

module Picasa
  class HTTP
    include HTTParty

    API_URL      = "https://picasaweb.google.com"
    API_AUTH_URL = "https://www.google.com"
    API_VERSION  = "2"

    format         :json
    default_params alt: :json

    headers        "User-Agent"      => "ruby-gem-picasa-v#{VERSION} (gzip)",
                   "GData-Version"   => API_VERSION,
                   "Accept-Encoding" => "gzip, deflate"

    base_uri       API_URL
  end
end
