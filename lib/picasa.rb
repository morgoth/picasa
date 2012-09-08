require "multi_xml"

require "./picasa/version"
require "./picasa/utils"
require "./picasa/exceptions"
require "./picasa/connection"
require "./picasa/client"
require "./picasa/template"

require "./picasa/api/album"
require "./picasa/api/photo"
require "./picasa/api/tag"

require "./picasa/presenter/album"
require "./picasa/presenter/album_list"
require "./picasa/presenter/author"
require "./picasa/presenter/content"
require "./picasa/presenter/link"
require "./picasa/presenter/media"
require "./picasa/presenter/photo"
require "./picasa/presenter/tag"
require "./picasa/presenter/tag_list"
require "./picasa/presenter/thumbnail"

module Picasa
  API_URL      = "https://picasaweb.google.com"
  API_AUTH_URL = "https://www.google.com"
  API_VERSION  = "2"
end
