require "picasa/presenter/base"

module Picasa
  module Presenter
    class Link < Base
      # @return [String]
      def rel
        @rel ||= safe_retrieve(parsed_body, "rel")
      end

      # @return [String]
      def type
        @type ||= safe_retrieve(parsed_body, "type")
      end

      # @return [String]
      def href
        @href ||= safe_retrieve(parsed_body, "href")
      end
    end
  end
end
