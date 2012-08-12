module Picasa
  module API
    class Album
      attr_reader :user_id, :password

      def initialize(credentials)
        @user_id  = credentials.fetch(:user_id)
        @password = credentials.fetch(:password, nil)
      end

      # Returns album list
      #
      def list(options = {})
        uri  = URI.parse("/data/feed/api/user/#{user_id}")
        parsed_body = Connection.new(:user_id => user_id, :password => password).get(uri.path, options)

        Presenter::AlbumList.new(parsed_body)
      end

      # Returns photo list
      #
      # ==== Options
      # * <tt>:max_results</tt>
      # * <tt>:tag</tt>
      def show(album_id, options = {})
        uri  = URI.parse("/data/feed/api/user/#{user_id}/albumid/#{album_id}")
        feed = Connection.new(:user_id => user_id, :password => password).get(uri.path, options)

        return feed["feed"] if feed && feed.has_key?("feed")
        feed
      end
      alias photos show
    end
  end
end
