require "picasa/presenter/base"

module Picasa
  module Presenter
    class Link < Base
      def rel
        @rel ||= safe_retrieve(parsed_body, "rel")
      end

      def type
        @type ||= safe_retrieve(parsed_body, "type")
      end

      def href
        @href ||= safe_retrieve(parsed_body, "href")
      end
    end
  end
end
