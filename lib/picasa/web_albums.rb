require "net/http"
require "xmlsimple"

module Picasa
  class WebAlbums
    def initialize(user)
      Picasa.config.google_user = user if user
      raise ArgumentError.new("You must specify google_user") unless Picasa.config.google_user
    end

    def albums opts=nil
      data = connect("/data/feed/api/user/#{Picasa.config.google_user}", opts)
      xml = XmlSimple.xml_in(data)
      albums = []
      xml["entry"].each do |album|
        attributes = {}
        attributes[:id] = album["id"][1]
        attributes[:title] = album["title"][0]["content"]
        attributes[:summary] = album["summary"][0]["content"]
        attributes[:photos_count] = album["numphotos"][0].to_i
        attributes[:photo] = album["group"][0]["content"]["url"]
        attributes[:thumbnail] = album["group"][0]["thumbnail"][0]["url"]
        attributes[:slideshow] = album["link"][1]["href"] + "#slideshow"
        albums << attributes
      end if xml["entry"]
      albums
    end

    def photos(album_id, opts=nil)
      data = connect("/data/feed/api/user/#{Picasa.config.google_user}/albumid/#{album_id}", opts)
      xml = XmlSimple.xml_in(data)
      photos = []
      xml["entry"].each do |photo|
        attributes = {}
        attributes[:id] = photo["id"][1]
        attributes[:title] = photo["group"][0]["description"][0]["content"]
        attributes[:thumbnail_1] = photo["group"][0]["thumbnail"][0]["url"]
        attributes[:thumbnail_2] = photo["group"][0]["thumbnail"][1]["url"]
        attributes[:thumbnail_3] = photo["group"][0]["thumbnail"][2]["url"]
        attributes[:photo] = photo["content"]["src"]
        photos << attributes
      end if xml["entry"]
      { :photos => photos, :slideshow => xml["link"][1]["href"] + "#slideshow" }
    end

    private

    def connect(url, opts=nil)
      full_url = "http://picasaweb.google.com#{ url }?#{ opts.try( :to_query ) }"
      Net::HTTP.get(URI.parse(full_url))
    end
  end
end
