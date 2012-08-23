require "picasa/presenter/base"

module Picasa
  module Presenter
    class Photo < Base
      # @return [Array<Presenter::Link>]
      def links
        @links ||= safe_retrieve(parsed_body, "link").map { |link| Link.new(link) }
      end

      # @return [Presenter::Media]
      def media
        @media ||= Media.new(safe_retrieve(parsed_body, "group"))
      end

      # @return [String]
      def id
        @id ||= array_wrap(safe_retrieve(parsed_body, "id"))[1]
      end

      # @return [DateTime]
      def published
        @published ||= map_to_date(safe_retrieve(parsed_body, "published"))
      end

      # @return [DateTime]
      def updated
        @updated ||= map_to_date(safe_retrieve(parsed_body, "updated"))
      end

      # @return [String]
      def title
        @title ||= safe_retrieve(parsed_body, "title")
      end

      # @return [String]
      def summary
        @summary ||= safe_retrieve(parsed_body, "summary")
      end

      # @return [String]
      def album_id
        @album_id ||= safe_retrieve(parsed_body, "albumid")
      end

      # @return [String]
      def access
        @access ||= safe_retrieve(parsed_body, "access")
      end

      # @return [Integer]
      def width
        @width ||= map_to_integer(safe_retrieve(parsed_body, "width"))
      end

      # @return [Integer]
      def height
        @height ||= map_to_integer(safe_retrieve(parsed_body, "height"))
      end

      # @return [Integer]
      def size
        @size ||= map_to_integer(safe_retrieve(parsed_body, "size"))
      end

      # @return [String]
      def checksum
        @checksum ||= safe_retrieve(parsed_body, "checksum")
      end

      # @return [String]
      def timestamp
        @timestamp ||= safe_retrieve(parsed_body, "timestamp")
      end

      # @return [Integer]
      def image_version
        @image_version ||= map_to_integer(safe_retrieve(parsed_body, "imageVersion"))
      end

      # @return [true, false, nil]
      def commenting_enabled
        @commenting_enabled ||= map_to_boolean(safe_retrieve(parsed_body, "commentingEnabled"))
      end

      # @return [Integer]
      def comment_count
        @comment_count ||= map_to_integer(safe_retrieve(parsed_body, "commentCount"))
      end

      # @return [String]
      def license
        @license ||= safe_retrieve(parsed_body, "license", "__content__")
      end
    end
  end
end
