module Picasa
  module Presenter
    class Thumbnail
      include Utils

      attr_reader :parsed_body

      def initialize(parsed_body)
        @parsed_body = parsed_body
      end

      def url
        @url ||= safe_retrieve(parsed_body, "url")
      end

      def width
        @width ||= map_to_integer(safe_retrieve(parsed_body, "width"))
      end

      def height
        @height ||= map_to_integer(safe_retrieve(parsed_body, "height"))
      end
    end
  end
end
