require "picasa/presenter/base"

module Picasa
  module Presenter
    class Tag < Base
      # @return [Presenter::Author]
      def author
        @author ||= Author.new(parsed_body["author"][0])
      end

      # @return [Array<Presenter::Link>]
      def links
        @links ||= array_wrap(safe_retrieve(parsed_body, "link")).map { |link| Link.new(link) }
      end

      # @return [DateTime]
      def updated
        @updated ||= map_to_date(safe_retrieve(parsed_body, "updated"))
      end

      # @return [String]
      def title
        @title ||= safe_retrieve(parsed_body, "title")
      end

      # @return [String]
      def etag
        @etag ||= safe_retrieve(parsed_body, "gd$etag")
      end

      # @return [String]
      def summary
        @summary ||= safe_retrieve(parsed_body, "summary")
      end

      # @return [String]
      def id
        @id ||= safe_retrieve(parsed_body, "id")
      end

      # @return [Integer]
      def weight
        @weight ||= map_to_integer(safe_retrieve(parsed_body, "weight"))
      end
    end
  end
end
