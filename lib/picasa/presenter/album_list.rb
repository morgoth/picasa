module Picasa
  module Presenter
    class AlbumList
      include Utils

      attr_reader :parsed_body

      def initialize(parsed_body)
        @parsed_body = parsed_body
      end

      def albums
        @albums ||= safe_retrieve(parsed_body, "feed", "entry")
      end
    end
  end
end
