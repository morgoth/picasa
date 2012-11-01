module Picasa
  class HTTPRead < HTTP
    format         :json
    default_params :v => API_VERSION, :alt => :json

    headers        "User-Agent"      => "ruby-gem-picasa-v#{VERSION} (gzip)",
                   "GData-Version"   => API_VERSION,
                   "Accept-Encoding" => "gzip, deflate"

  end
end
