module Picasa
  module Presenter
    class AlbumList
      include Utils

      attr_reader :parsed_body

      def initialize(parsed_body)
        @parsed_body = parsed_body
      end

      def author
        @author ||= Author.new(safe_retrieve(parsed_body, "author"))
      end

      def entries
        @entries ||= safe_retrieve(parsed_body, "entry").map { |entry| Album.new(entry) }
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
        return @total_results if defined?(@total_results)
        if total_results = safe_retrieve(parsed_body, "openSearch:totalResults")
          @total_results = total_results.to_i
        end
      end

      def start_index
        return @start_index if defined?(@start_index)
        if start_index = safe_retrieve(parsed_body, "openSearch:startIndex")
          @start_index = start_index.to_i
        end
      end

      def items_per_page
        return @items_per_page if defined?(@items_per_page)
        if items_per_page = safe_retrieve(parsed_body, "openSearch:itemsPerPage")
          @items_per_page = items_per_page.to_i
        end
      end

      def user
        @user ||= safe_retrieve(parsed_body, "gphoto:user")
      end

      def nickname
        @nickname ||= safe_retrieve(parsed_body, "gphoto:nickname")
      end

      def thumbnail
        @thumbnail ||= safe_retrieve(parsed_body, "gphoto:thumbnail")
      end
    end
  end
end
