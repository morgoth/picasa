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

require "picasa/presenter/album_list"

module Picasa
  # def self.albums(options = {})
  #   options[:user_id] = options.delete(:google_user) if options.has_key?(:google_user)

  #   album = Picasa::Album.new(options[:user_id], options.delete(:password))
  #   album.list options
  # end

  # def self.photos(options = {})
  #   raise ArgumentError.new("You must specify album_id") unless options[:album_id]

  #   options[:user_id] = options.delete(:google_user) if options.has_key?(:google_user)

  #   album   = Picasa::Album.new(options[:user_id], options.delete(:password))
  #   album.show options.delete(:album_id), options
  # end
end
