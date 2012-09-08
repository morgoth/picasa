require "./picasa/api/base"

module Picasa
  module API
    class Album < Base
      # Returns album list
      #
      # @param [Hash] options additional options included in request
      # @option options [all, private, public, visible] :access which data should be retrieved when authenticated
      # @option options [String] :fields which fields should be retrieved https://developers.google.com/gdata/docs/2.0/reference#PartialResponseRequest
      # @option options [String, Integer] :max_results how many albums response should include
      # @option options [String, Integer] :start_index 1-based index of the first result to be retrieved
      #
      # @return [Presenter::AlbumList]
      def list(options = {})
        uri = URI.parse("/data/feed/api/user/#{user_id}")
        parsed_body = Connection.new(credentials).get(uri.path, options)

        Presenter::AlbumList.new(parsed_body["feed"])
      end

      # Returns photo list for given album
      #
      # @param [String] album_id album id
      # @param [Hash] options additional options included in request
      # @option options [String, Integer] :max_results max number of returned results
      # @option options [String] :tag include photos with given tag only
      #
      # @return [Presenter::Album]
      # @raise [NotFoundError] raised when album cannot be found
      def show(album_id, options = {})
        uri = URI.parse("/data/feed/api/user/#{user_id}/albumid/#{album_id}")
        parsed_body = Connection.new(credentials).get(uri.path, options)

        Presenter::Album.new(parsed_body["feed"])
      end

      # Creates album
      #
      # @param [Hash] params album parameters
      # @option options [String] :title title of album (required)
      # @option options [String] :summary summary of album
      # @option options [String] :location location of album photos (i.e. Poland)
      # @option options [String] :access [public, private, protected]
      # @option options [String] :timestamp timestamp of album (default to now)
      # @option options [String] :keywords keywords (i.e. "vacation, poland")
      #
      # @return [Presenter::Album]
      def create(params = {})
        params[:title] || raise(ArgumentError, "You must specify title")
        params[:timestamp] ||= Time.now.to_i

        template = Template.new(:new_album, params)
        uri = URI.parse("/data/feed/api/user/#{user_id}")
        parsed_body = Connection.new(credentials).post(uri.path, template.render)
        Presenter::Album.new(parsed_body["entry"])
      end

      # Destroys given album
      #
      # @param [String] album_id album id
      # @param [Hash] options request parameters
      # @option options [String] :etag destroys only when ETag matches - protects before destroying other client changes
      #
      # @return [true]
      # @raise [NotFoundError] raised when album cannot be found
      # @raise [PreconditionFailedError] raised when ETag does not match
      def destroy(album_id, options = {})
        headers = {"If-Match" => options.fetch(:etag, "*")}
        uri = URI.parse("/data/entry/api/user/#{user_id}/albumid/#{album_id}")
        Connection.new(credentials).delete(uri.path, headers)
        true
      end
      alias :delete :destroy
    end
  end
end
