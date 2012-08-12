require "picasa/presenter/base"

module Picasa
  module Presenter
    class Photo < Base
      def links
        @links ||= safe_retrieve(parsed_body, "link").map { |link| Link.new(link) }
      end

      def media
        @media ||= Media.new(safe_retrieve(parsed_body, "media:group"))
      end

      def id
        @id ||= safe_retrieve(parsed_body, "gphoto:id")
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
        @album_id ||= safe_retrieve(parsed_body, "gphoto:albumid")
      end

      def access
        @access ||= safe_retrieve(parsed_body, "gphoto:access")
      end

      def width
        @width ||= map_to_integer(safe_retrieve(parsed_body, "gphoto:width"))
      end

      def height
        @height ||= map_to_integer(safe_retrieve(parsed_body, "gphoto:height"))
      end

      def size
        @size ||= map_to_integer(safe_retrieve(parsed_body, "gphoto:size"))
      end

      def checksum
        @checksum ||= safe_retrieve(parsed_body, "gphoto:checksum")
      end

      def timestamp
        @timestamp ||= safe_retrieve(parsed_body, "gphoto:timestamp")
      end

      def image_version
        @image_version ||= map_to_integer(safe_retrieve(parsed_body, "gphoto:imageVersion"))
      end

      def commenting_enabled
        @commenting_enabled ||= map_to_boolean(safe_retrieve(parsed_body, "gphoto:commentingEnabled"))
      end

      def comment_count
        @comment_count ||= map_to_integer(safe_retrieve(parsed_body, "gphoto:commentCount"))
      end

      def license
        @license ||= safe_retrieve(parsed_body, "gphoto:license", "__content__")
      end
    end
  end
end
