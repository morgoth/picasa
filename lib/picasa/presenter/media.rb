require "picasa/presenter/base"

module Picasa
  module Presenter
    class Media < Base
      def thumbnails
        @thumbnails ||= array_wrap(safe_retrieve(parsed_body, "thumbnail")).map { |thumbnail| Thumbnail.new(thumbnail) }
      end

      def credit
        @credit ||= safe_retrieve(parsed_body, "credit")
      end

      def description
        @description ||= safe_retrieve(parsed_body, "description")
      end

      def keywords
        @keywords ||= safe_retrieve(parsed_body, "keywords")
      end

      def title
        @title ||= safe_retrieve(parsed_body, "title", "__content__")
      end
    end
  end
end
