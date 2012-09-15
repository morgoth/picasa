require "picasa/presenter/base"

module Picasa
  module Presenter
    class Thumbnail < Base
      # @return [String]
      def url
        @url ||= safe_retrieve(parsed_body, "url")
      end

      # @return [String]
      def width
        @width ||= map_to_integer(safe_retrieve(parsed_body, "width"))
      end

      # @return [String]
      def height
        @height ||= map_to_integer(safe_retrieve(parsed_body, "height"))
      end
    end
  end
end
