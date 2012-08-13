require "picasa/presenter/base"

module Picasa
  module Presenter
    class AlbumList < Base
      def author
        @author ||= Author.new(safe_retrieve(parsed_body, "author"))
      end

      def entries
        @entries ||= array_wrap(safe_retrieve(parsed_body, "entry")).map { |entry| Album.new(entry) }
      end
      alias :albums :entries

      def links
        @links ||= safe_retrieve(parsed_body, "link").map { |link| Link.new(link) }
      end

      def title
        @title ||= safe_retrieve(parsed_body, "title")
      end

      def updated
        @updated ||= safe_retrieve(parsed_body, "updated")
      end

      def icon
        @icon ||= safe_retrieve(parsed_body, "icon")
      end

      def generator
        @generator ||= safe_retrieve(parsed_body, "generator", "__content__")
      end

      def total_results
        @total_results ||= map_to_integer(safe_retrieve(parsed_body, "totalResults"))
      end

      def start_index
        @start_index ||= map_to_integer(safe_retrieve(parsed_body, "startIndex"))
      end

      def items_per_page
        @items_per_page ||= map_to_integer(safe_retrieve(parsed_body, "itemsPerPage"))
      end

      def user
        @user ||= safe_retrieve(parsed_body, "user")
      end

      def nickname
        @nickname ||= safe_retrieve(parsed_body, "nickname")
      end

      def thumbnail
        @thumbnail ||= safe_retrieve(parsed_body, "thumbnail")
      end
    end
  end
end
