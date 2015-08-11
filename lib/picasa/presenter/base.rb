module Picasa
  module Presenter
    class Base
      include Utils

      attr_reader :parsed_body

      def initialize(parsed_body)
        @parsed_body = parsed_body
      end

      def inspect
        "#<#{self.class}>"
      end
    end
  end
end
