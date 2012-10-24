require "picasa/presenter/base"

module Picasa
  module Presenter
    class Media < Base
      # @return [Array<Presenter::Thumbnail>]
      def thumbnails
        @thumbnails ||= array_wrap(safe_retrieve(parsed_body, "media$thumbnail")).map { |thumbnail| Thumbnail.new(thumbnail) }
      end

      # @return [String]
      def credit
        @credit ||= parsed_body["media$credit"][0]["$t"]
      end

      # @return [String]
      def description
        @description ||= safe_retrieve(parsed_body, "media$description", "$t")
      end

      # @return [String]
      def keywords
        @keywords ||= safe_retrieve(parsed_body, "media$keywords")
      end

      # @return [String]
      def title
        @title ||= safe_retrieve(parsed_body, "media$title", "$t")
      end
    end
  end
end
