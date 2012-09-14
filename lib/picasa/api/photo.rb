require "picasa/api/base"

module Picasa
  module API
    class Photo < Base
      # Creates photo for given album
      #
      # @param [String] album_id album id
      # @param [Hash] options request parameters
      # @option options [String] :file_path path to photo file, rest of required attributes might be guessed based on file (i.e. "/home/john/Images/me.png")
      # @option options [String] :title title of photo
      # @option options [String] :summary summary of photo
      # @option options [String] :binary binary data (i.e. File.open("my-photo.png", "rb").read)
      # @option options [String] :content_type ["image/jpeg", "image/png", "image/bmp", "image/gif"] content type of given image
      def create(album_id, params = {})
        file = params[:file_path] ? File.new(params.delete(:file_path)) : nil
        params[:boundary]     ||= "===============PicasaRubyGem=="
        params[:title]        ||= (file && file.name) || raise(ArgumentError.new("title must be specified"))
        params[:binary]       ||= (file && file.binary) || raise(ArgumentError.new("binary must be specified"))
        params[:content_type] ||= (file && file.content_type) || raise(ArgumentError.new("content_type must be specified"))
        template = Template.new(:new_photo, params)
        headers = {"Content-Type" => "multipart/related; boundary=\"#{params[:boundary]}\""}

        uri = URI.parse("/data/feed/api/user/#{user_id}/albumid/#{album_id}")
        parsed_body = Connection.new(credentials).post(uri.path, template.render, headers)
        Presenter::Photo.new(parsed_body["entry"])
      end
    end
  end
end
