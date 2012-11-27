require "picasa/presenter/base"

module Picasa
  module Presenter
    class Album < Base
      # @return [Presenter::Author]
      def author
        @author ||= Author.new(parsed_body["author"][0])
      end

      # @return [Array<Presenter::Photo>]
      def entries
        @entries ||= array_wrap(safe_retrieve(parsed_body, "entry")).map { |photo| Photo.new(photo) }
      end
      alias :photos :entries

      # @return [Array<Presenter::Link>]
      def links
        @links ||= array_wrap(safe_retrieve(parsed_body, "link")).map { |link| Link.new(link) }
      end

      # @return [Presenter::Media]
      def media
        @media ||= Media.new(safe_retrieve(parsed_body, "media$group"))
      end

      # @return [DateTime]
      def published
        @published ||= map_to_date(safe_retrieve(parsed_body, "published"))
      end

      # @return [DateTime]
      def updated
        @updated ||= map_to_date(safe_retrieve(parsed_body, "updated"))
      end

      # @return [String]
      def etag
        @etag ||= safe_retrieve(parsed_body, "gd$etag")
      end

      # @return [String]
      def title
        @title ||= safe_retrieve(parsed_body, "title")
      end

      # @return [String]
      def summary
        @summary ||= safe_retrieve(parsed_body, "summary")
      end

      # @return [String]
      def rights
        @rights ||= safe_retrieve(parsed_body, "rights")
      end

      # @return [String]
      def id
        @id ||= safe_retrieve(parsed_body, "gphoto$id")
      end

      # @return [String]
      def name
        @name ||= safe_retrieve(parsed_body, "gphoto$name")
      end

      # @return [String]
      def location
        @location ||= safe_retrieve(parsed_body, "gphoto$location")
      end

      # @return [String]
      def access
        @access ||= safe_retrieve(parsed_body, "gphoto$access")
      end

      # @return [String]
      def timestamp
        @timestamp ||= safe_retrieve(parsed_body, "gphoto$timestamp")
      end

      # @return [String]
      def numphotos
        @numphotos ||= map_to_integer(safe_retrieve(parsed_body, "gphoto$numphotos"))
      end

      # @return [String]
      def user
        @user ||= safe_retrieve(parsed_body, "gphoto$user")
      end

      # @return [String]
      def nickname
        @nickname ||= safe_retrieve(parsed_body, "gphoto$nickname")
      end

      # @return [true, false, nil]
      def allow_prints
        @allow_prints ||= map_to_boolean(safe_retrieve(parsed_body, "gphoto$allowPrints"))
      end

      # @return [true, false, nil]
      def allow_downloads
        @allow_downloads ||= map_to_boolean(safe_retrieve(parsed_body, "gphoto$allowDownloads"))
      end
    end
  end
end
