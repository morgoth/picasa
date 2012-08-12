# require "picasa/client"
# require "picasa/album"
# require "picasa/photo"
# require "picasa/tag"

require "multi_xml"

require "picasa/version"
require "picasa/utils"
require "picasa/exceptions"
require "picasa/connection"
require "picasa/api/album"

require "picasa/presenter/album"
require "picasa/presenter/album_list"
require "picasa/presenter/author"
require "picasa/presenter/link"
require "picasa/presenter/photo"

module Picasa
  API_URL         = "https://picasaweb.google.com"
  API_AUTH_URL    = "https://www.google.com"
  API_VERSION = "2"
end
