require "picasa/presenter/base"

module Picasa
  module Presenter
    class Author < Base
      # @return [String]
      def name
        @name ||= safe_retrieve(parsed_body, "name")
      end

      # @return [String]
      def uri
        @uri ||= safe_retrieve(parsed_body, "uri")
      end
    end
  end
end
