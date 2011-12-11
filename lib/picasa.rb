require "picasa/client"
require "picasa/album"
require "picasa/photo"
require "picasa/version"

module Picasa
  def self.albums(options = {})
    options[:user_id] = options.delete(:google_user) if options.has_key? :google_user

    album = Picasa::Album.new(options)
    album.list options
  end

  def self.photos(options = {})
    raise ArgumentError.new("You must specify album_id") unless options[:album_id]

    options[:user_id] = options.delete(:google_user) if options.has_key? :google_user

    album   = Picasa::Album.new(options[:user_id])
    album.show options.delete(:album_id), options
  end

  class << self
    attr_accessor :user_id

    def configure
      yield self
    end
  end
end
