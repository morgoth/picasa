module Picasa
  module API
    class Album
      attr_reader :user_id, :password

      def initialize(credentials)
        if MultiXml.parser.to_s == "MultiXml::Parsers::Ox"
          raise StandardError, "MultiXml parser is set to :ox - picasa gem will not work with it currently, use one of: :libxml, :nokogiri, :rexml"
        end
        @user_id  = credentials.fetch(:user_id)
        @password = credentials.fetch(:password, nil)
      end

      # Returns album list
      #
      def list(options = {})
        uri = URI.parse("/data/feed/api/user/#{user_id}")
        parsed_body = Connection.new(:user_id => user_id, :password => password).get(uri.path, options)

        Presenter::AlbumList.new(parsed_body["feed"])
      end

      # Returns photo list for given album
      #
      # ==== Options
      # * <tt>:max_results</tt>
      # * <tt>:tag</tt>
      def show(album_id, options = {})
        uri = URI.parse("/data/feed/api/user/#{user_id}/albumid/#{album_id}")
        parsed_body = Connection.new(:user_id => user_id, :password => password).get(uri.path, options)

        Presenter::Album.new(parsed_body["feed"])
      end
    end
  end
end
