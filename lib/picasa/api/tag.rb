require "picasa/api/base"

module Picasa
  module API
    class Tag < Base
      # Returns tag list - when album_id is not specified, list of user tags will be returned
      #
      # @param [Hash] options additional options included in request
      # @option options [String] :album_id retrieve tags for given album
      # @option options [String] :photo_id retrieve tags for given photo (album_id must be provided)
      #
      # @return [Presenter::TagList]
      def list(options = {})
        album_id = options[:album_id]
        photo_id = options[:photo_id]
        raise(ArgumentError, "You must specify album_id when providing photo_id") if photo_id && !album_id

        path = "/data/feed/api/user/#{user_id}"
        path << "/albumid/#{album_id}" if album_id
        path << "/photoid/#{photo_id}" if photo_id

        uri = URI.parse(path)
        response = Connection.new(credentials).get(uri.path, options.merge(:kind => "tag"))

        Presenter::TagList.new(MultiXml.parse(response.body)["feed"])
      end

      # Creates a tag for a photo.
      #
      # @param [Hash]
      # @option options [String] :album_id id pof album
      # @option options [String] :photo_id id of photo
      # @option options [String] :title name of tag
      #
      # @return [Presenter::Tag]
      def create(params = {})
        album_id = params.delete(:album_id) || raise(ArgumentError, "You must specify album_id")
        photo_id = params.delete(:photo_id) || raise(ArgumentError, "You must specify photo_id")
        params[:title] || raise(ArgumentError, "You must specify title")

        path = "/data/feed/api/user/#{user_id}/albumid/#{album_id}/photoid/#{photo_id}"

        template = Template.new("new_tag", params)

        uri = URI.parse(path)
        response = Connection.new(credentials).post(uri.path, template.render)

        Presenter::Tag.new(MultiXml.parse(response.body)["entry"])
      end
    end
  end
end
