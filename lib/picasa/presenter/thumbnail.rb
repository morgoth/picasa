require "picasa/presenter/base"

module Picasa
  module Presenter
    class Thumbnail < Base
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
