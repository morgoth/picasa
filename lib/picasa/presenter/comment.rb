require "picasa/presenter/base"

module Picasa
  module Presenter
    class Comment < Base
      # @return [Presenter::Author]
      def author
        @author ||= Author.new(safe_retrieve(parsed_body, "author"))
      end

      # @return [Array<Presenter::Link>]
      def links
        @links ||= array_wrap(safe_retrieve(parsed_body, "link")).map { |link| Link.new(link) }
      end

      # @return [DateTime]
      def published
        @published ||= map_to_date(safe_retrieve(parsed_body, "published"))
      end

      # @return [DateTime]
      def updated
        @updated ||= map_to_date(safe_retrieve(parsed_body, "updated"))
      end

      # @return [DateTime]
      def edited
        @edited ||= map_to_date(safe_retrieve(parsed_body, "edited"))
      end

      # @return [String]
      def title
        @title ||= safe_retrieve(parsed_body, "title")
      end

      # @return [String]
      def etag
        @etag ||= safe_retrieve(parsed_body, "etag")
      end

      # @return [String]
      def content
        @content ||= safe_retrieve(parsed_body, "content", "__content__")
      end

      # @return [String]
      def id
        @id ||= array_wrap(safe_retrieve(parsed_body, "id")).last
      end

      # @return [String]
      def photo_id
        @photo_id ||= safe_retrieve(parsed_body, "photoid")
      end
    end
  end
end
