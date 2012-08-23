require "picasa/presenter/base"

module Picasa
  module Presenter
    class Media < Base
      # @return Array<Presenter::Thumbnail>
      def thumbnails
        @thumbnails ||= array_wrap(safe_retrieve(parsed_body, "thumbnail")).map { |thumbnail| Thumbnail.new(thumbnail) }
      end

      # @return [String]
      def credit
        @credit ||= safe_retrieve(parsed_body, "credit")
      end

      # @return [String]
      def description
        @description ||= safe_retrieve(parsed_body, "description")
      end

      # @return [String]
      def keywords
        @keywords ||= safe_retrieve(parsed_body, "keywords")
      end

      # @return [String]
      def title
        @title ||= safe_retrieve(parsed_body, "title", "__content__")
      end
    end
  end
end
