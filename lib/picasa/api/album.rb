module Picasa
  module API
    class Album
      attr_reader :user_id, :credentials

      # @param [Hash] credentials
      # @option credentials [String] :user_id google username/email
      # @option credentials [String] :password password for given username/email
      def initialize(credentials)
        if MultiXml.parser.to_s == "MultiXml::Parsers::Ox"
          raise StandardError, "MultiXml parser is set to :ox - picasa gem will not work with it currently, use one of: :libxml, :nokogiri, :rexml"
        end
        @user_id  = credentials.fetch(:user_id)
        @credentials = credentials
      end

      # Returns album list
      #
      # @param [Hash] options additional options included in request
      # @option options [all, private, public, visible] :access which data should be retrieved when authenticated
      # @option options [String] :fields which fields should be retrieved https://developers.google.com/gdata/docs/2.0/reference#fields
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
    end
  end
end
