module Picasa
  module Presenter
    class Link
      include Utils

      attr_reader :parsed_body

      def initialize(parsed_body)
        @parsed_body = parsed_body
      end

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
