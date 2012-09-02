require "picasa/api/base"

module Picasa
  module API
    class Photo < Base
      # Creates photo for given album
      #
      # @param [String] album_id album id
      # @param [Hash] options request parameters
      # @option options [String] :title title of album (required)
      # @option options [String] :summary summary of album
      # @option options [String] :binary binary data (i.e. File.open("my-photo.png", "rb").read)
      # @option options [String] :content_type ["image/jpeg", "image/png", "image/bmp", "image/gif"] content type of given image
      def create(album_id, params = {})
        params[:binary] || raise(ArgumentError, "You must specify binary")
        params[:content_type] || raise(ArgumentError, "You must specify image content_type")
        params[:boundary] ||= "===============PicasaRubyGem=="
        template = Template.new(:new_photo, params)
        headers = {"Content-Type" => "multipart/related; boundary=\"#{params[:boundary]}\""}

        uri = URI.parse("/data/feed/api/user/#{user_id}/albumid/#{album_id}")
        parsed_body = Connection.new(credentials).post(uri.path, template.render, headers)
        Presenter::Photo.new(parsed_body["entry"])
      end
    end
  end
end
