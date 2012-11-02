require "picasa/presenter/base"

module Picasa
  module Presenter
    class CommentList < Base
      # @return [Presenter::Author]
      def author
        @author ||= Author.new(parsed_body["author"][0])
      end

      # @return [Array<Presenter::Comment>]
      def entries
        @entries ||= safe_retrieve(parsed_body, "entry").map { |entry| Comment.new(entry) }
      end
      alias :comments :entries

      # @return [Array<Presenter::Link>]
      def links
        @links ||= safe_retrieve(parsed_body, "link").map { |link| Link.new(link) }
      end

      # @return [String]
      def title
        @title ||= safe_retrieve(parsed_body, "title")
      end

      # @return [DateTime]
      def updated
        @updated ||= map_to_date(safe_retrieve(parsed_body, "updated"))
      end

      # @return [String]
      def icon
        @icon ||= safe_retrieve(parsed_body, "icon")
      end

      # @return [String]
      def generator
        @generator ||= safe_retrieve(parsed_body, "generator", "$t")
      end

      # @return [Integer]
      def total_results
        @total_results ||= map_to_integer(safe_retrieve(parsed_body, "openSearch$totalResults"))
      end

      # @return [Integer]
      def start_index
        @start_index ||= map_to_integer(safe_retrieve(parsed_body, "openSearch$startIndex"))
      end

      # @return [Integer]
      def items_per_page
        @items_per_page ||= map_to_integer(safe_retrieve(parsed_body, "openSearch$itemsPerPage"))
      end

      # @return [String]
      def user
        @user ||= safe_retrieve(parsed_body, "gphoto$user")
      end

      # @return [String]
      def nickname
        @nickname ||= safe_retrieve(parsed_body, "gphoto$nickname")
      end

      # @return [String]
      def thumbnail
        @thumbnail ||= safe_retrieve(parsed_body, "gphoto$thumbnail")
      end
    end
  end
end
