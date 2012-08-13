require "picasa/presenter/base"

module Picasa
  module Presenter
    class Photo < Base
      def links
        @links ||= safe_retrieve(parsed_body, "link").map { |link| Link.new(link) }
      end

      def media
        @media ||= Media.new(safe_retrieve(parsed_body, "group"))
      end

      def id
        @id ||= array_wrap(safe_retrieve(parsed_body, "id"))[1]
      end

      def published
        @published ||= safe_retrieve(parsed_body, "published")
      end

      def updated
        @updated ||= safe_retrieve(parsed_body, "updated")
      end

      def title
        @title ||= safe_retrieve(parsed_body, "title")
      end

      def summary
        @summary ||= safe_retrieve(parsed_body, "summary")
      end

      def album_id
        @album_id ||= safe_retrieve(parsed_body, "albumid")
      end

      def access
        @access ||= safe_retrieve(parsed_body, "access")
      end

      def width
        @width ||= map_to_integer(safe_retrieve(parsed_body, "width"))
      end

      def height
        @height ||= map_to_integer(safe_retrieve(parsed_body, "height"))
      end

      def size
        @size ||= map_to_integer(safe_retrieve(parsed_body, "size"))
      end

      def checksum
        @checksum ||= safe_retrieve(parsed_body, "checksum")
      end

      def timestamp
        @timestamp ||= safe_retrieve(parsed_body, "timestamp")
      end

      def image_version
        @image_version ||= map_to_integer(safe_retrieve(parsed_body, "imageVersion"))
      end

      def commenting_enabled
        @commenting_enabled ||= map_to_boolean(safe_retrieve(parsed_body, "commentingEnabled"))
      end

      def comment_count
        @comment_count ||= map_to_integer(safe_retrieve(parsed_body, "commentCount"))
      end

      def license
        @license ||= safe_retrieve(parsed_body, "license", "__content__")
      end
    end
  end
end
