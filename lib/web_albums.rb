module Picasa
  class WebAlbums
    attr_accessor :google_user

    def initialize(google_user)
      @google_user = google_user
    end

    def albums
      data = connect("/data/feed/api/user/#{google_user}")
      xml=XmlSimple.xml_in(data)
      albums = []
      xml['entry'].each do |album|
        attribute = {}
        attribute[:id] = album['id'][1]
        attribute[:title] = album['title'][0]['content']
        attribute[:photos_count] = album['numphotos'][0].to_i
        albums << attribute
      end
      albums
    end

    def photos(album_id)
      data = connect("/data/feed/api/user/#{google_user}/albumid/#{album_id}")
      xml = XmlSimple.xml_in(data)
      photos = []
      xml['entry'].each do |photo|
        attribute = {}
        attribute[:title] = photo['group'][0]['description'][0]['content'] #returns nil if empty
        attribute[:thumbnail_1] = photo['group'][0]['thumbnail'][0]['url']
        attribute[:thumbnail_2] = photo['group'][0]['thumbnail'][1]['url']
        attribute[:thumbnail_3] = photo['group'][0]['thumbnail'][2]['url']
        #attributes[:photo] << photo['group'][0]['content']['url']
        attribute[:photo] = photo['content']['src']
        photos << attribute
      end
      { :photos => photos, :slideshow => xml['link'][2]['href'] }
    end

    private

    def connect(url)
      full_url = "http://picasaweb.google.com" + url
      Net::HTTP.get(URI.parse(full_url))
    end
  end
end