module Picasa
  module Presenter
    class Author
      include Utils

      attr_reader :parsed_body

      def initialize(parsed_body)
        @parsed_body = parsed_body
      end

      def name
        @name ||= safe_retrieve(parsed_body, "name")
      end

      def uri
        @uri ||= safe_retrieve(parsed_body, "uri")
      end
    end
  end
end
