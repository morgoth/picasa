module Picasa
  class HTTPRead < HTTP
    format         :json
    default_params :v => API_VERSION, :alt => :json
  end
end
