module Picasa
  require 'net/http'
  require "xmlsimple"

  require 'web_albums.rb'

  def self.albums(options = {})
    raise ArgumentError, "You must specify google_user" unless options[:google_user]
    web_albums = Picasa::WebAlbums.new(options[:google_user])
    web_albums.albums
  end

  def self.photos(options = {})
    unless options[:google_user] and options[:album_id]
      raise ArgumentError, "You must specify google_user and album_id"
    end
    web_albums = Picasa::WebAlbums.new(options[:google_user])
    web_albums.photos(options[:album_id])
  end
end
