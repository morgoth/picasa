module Picasa
  module Presenter
    class Media
      include Utils

      attr_reader :parsed_body

      def initialize(parsed_body)
        @parsed_body = parsed_body
      end

      def thumbnails
        @thumbnails ||= array_wrap(safe_retrieve(parsed_body, "media:thumbnail")).map { |thumbnail| Thumbnail.new(thumbnail) }
      end

      def credit
        @credit ||= safe_retrieve(parsed_body, "media:credit")
      end

      def description
        @description ||= safe_retrieve(parsed_body, "media:description")
      end

      def keywords
        @keywords ||= safe_retrieve(parsed_body, "media:keywords")
      end

      def title
        @title ||= safe_retrieve(parsed_body, "media:title", "__content__")
      end
    end
  end
end
