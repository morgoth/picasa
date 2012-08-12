require "picasa/presenter/base"

module Picasa
  module Presenter
    class Author < Base
      def name
        @name ||= safe_retrieve(parsed_body, "name")
      end

      def uri
        @uri ||= safe_retrieve(parsed_body, "uri")
      end
    end
  end
end
