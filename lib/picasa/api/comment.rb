require "picasa/api/base"

module Picasa
  module API
    class Comment < Base
      # Returns comment list - when album_id is not specified, list of user comments will be returned
      #
      # @param [Hash] options additional options included in request
      # @option options [String] :album_id retrieve comments for given album
      # @option options [String] :photo_id retrieve comments for given photo (album_id must be provided)
      #
      # @return [Presenter::CommentList]
      def list(options = {})
        album_id = options.delete(:album_id)
        photo_id = options.delete(:photo_id)
        raise(ArgumentError, "You must specify album_id when providing photo_id") if photo_id && !album_id

        path = "/data/feed/api/user/#{user_id}"
        path << "/albumid/#{album_id}" if album_id
        path << "/photoid/#{photo_id}" if photo_id

        uri = URI.parse(path)
        response = Connection.new.get(:path => uri.path, :query => options.merge(:kind => "comment"), :headers => auth_header)

        Presenter::CommentList.new(MultiXml.parse(response.body)["feed"])
      end
    end
  end
end
