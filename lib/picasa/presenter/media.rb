require "picasa/presenter/base"

module Picasa
  module Presenter
    class Media < Base
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
