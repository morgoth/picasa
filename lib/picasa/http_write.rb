module Picasa
  class HTTPWrite < HTTP
    format         :json
    default_params :alt => :json
    headers        "User-Agent"      => "ruby-gem-picasa-v#{VERSION} (gzip)",
                   "GData-Version"   => API_VERSION,
                   "Content-Type"    => "application/atom+xml",
                   "Accept-Encoding" => "gzip, deflate"
  end
end
