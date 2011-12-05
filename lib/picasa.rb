require "picasa/web_albums"
require "picasa/client"
require "picasa/album"
require "picasa/version"

module Picasa
  def self.albums(options = {})
    web_albums = Picasa::WebAlbums.new(options[:google_user])
    web_albums.albums
  end

  def self.photos(options = {})
    raise ArgumentError.new("You must specify album_id") unless options[:album_id]
    web_albums = Picasa::WebAlbums.new(options[:google_user])
    web_albums.photos(options[:album_id])
  end

  class << self
    attr_accessor :user_id

    def configure
      yield self
    end
  end
end
