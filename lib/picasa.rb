require "multi_xml"
require "ox"

require "picasa/version"
require "picasa/utils"
require "picasa/exceptions"
require "picasa/connection"
require "picasa/client"
require "picasa/api/album"

require "picasa/presenter/album"
require "picasa/presenter/album_list"
require "picasa/presenter/author"
require "picasa/presenter/link"
require "picasa/presenter/media"
require "picasa/presenter/photo"
require "picasa/presenter/thumbnail"

# Currently it only works with ox parser
MultiXml.parser = :ox

module Picasa
  API_URL      = "https://picasaweb.google.com"
  API_AUTH_URL = "https://www.google.com"
  API_VERSION  = "2"
end
