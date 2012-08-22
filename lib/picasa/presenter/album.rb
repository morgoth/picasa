require "picasa/presenter/base"

module Picasa
  module Presenter
    class Album < Base
      def author
        @author ||= Author.new(safe_retrieve(parsed_body, "author"))
      end

      def entries
        @entries ||= array_wrap(safe_retrieve(parsed_body, "entry")).map { |photo| Photo.new(photo) }
      end
      alias :photos :entries

      def links
        @links ||= safe_retrieve(parsed_body, "link").map { |link| Link.new(link) }
      end

      def media
        @media ||= Media.new(safe_retrieve(parsed_body, "group"))
      end

      def published
        @published ||= map_to_date(safe_retrieve(parsed_body, "published"))
      end

      def updated
        @updated ||= map_to_date(safe_retrieve(parsed_body, "updated"))
      end

      def title
        @title ||= safe_retrieve(parsed_body, "title")
      end

      def summary
        @summary ||= safe_retrieve(parsed_body, "summary")
      end

      def rights
        @rights ||= safe_retrieve(parsed_body, "rights")
      end

      def id
        @id ||= array_wrap(safe_retrieve(parsed_body, "id"))[1]
      end

      def name
        @name ||= safe_retrieve(parsed_body, "name")
      end

      def location
        @location ||= safe_retrieve(parsed_body, "location")
      end

      def access
        @access ||= safe_retrieve(parsed_body, "access")
      end

      def timestamp
        @timestamp ||= safe_retrieve(parsed_body, "timestamp")
      end

      def numphotos
        @numphotos ||= map_to_integer(safe_retrieve(parsed_body, "numphotos"))
      end

      def user
        @user ||= safe_retrieve(parsed_body, "user")
      end

      def nickname
        @nickname ||= safe_retrieve(parsed_body, "nickname")
      end
    end
  end
end
