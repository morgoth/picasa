module Picasa
  require 'net/http'
  require "xmlsimple"

  require 'web_albums.rb'

  def self.albums(options = {})
    web_albums = Picasa::WebAlbums.new(options[:google_user])
    web_albums.albums
  end

  def self.photos(options = {})
    web_albums = Picasa::WebAlbums.new(options[:google_user])
    web_albums.photos(options[:album_id])
  end
end
