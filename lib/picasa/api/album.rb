module Picasa
  module API
    class Album
      attr_reader :user_id, :credentials

      # @param [Hash] credentials
      #   @option options [String] :user_id google username/email
      #   @option options [String] :password password for given username/email
      def initialize(credentials)
        if MultiXml.parser.to_s == "MultiXml::Parsers::Ox"
          raise StandardError, "MultiXml parser is set to :ox - picasa gem will not work with it currently, use one of: :libxml, :nokogiri, :rexml"
        end
        @user_id  = credentials.fetch(:user_id)
        @credentials = credentials
      end

      # Returns album list
      #
      # @param [Hash] additional options included in request
      #
      # @return [Presenter::AlbumList]
      def list(options = {})
        uri = URI.parse("/data/feed/api/user/#{user_id}")
        parsed_body = Connection.new(credentials).get(uri.path, options)

        Presenter::AlbumList.new(parsed_body["feed"])
      end

      # Returns photo list for given album
      #
      # @param [String] id of album
      # @param [Hash] additional options included in request
      #   @option options [String, Integer] :max_results max number of returned results
      #   @option options [String] :tag include photos with given tag only
      #
      # @return [Presenter::Album]
      def show(album_id, options = {})
        uri = URI.parse("/data/feed/api/user/#{user_id}/albumid/#{album_id}")
        parsed_body = Connection.new(credentials).get(uri.path, options)

        Presenter::Album.new(parsed_body["feed"])
      end
    end
  end
end
