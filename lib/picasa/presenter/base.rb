module Picasa
  module Presenter
    class Base
      include Utils

      attr_reader :parsed_body

      def initialize(parsed_body)
        @parsed_body = parsed_body
      end

      def inspect
        inspection = methods_to_inspect.map do |method|
          value = send(method)
          value = value.nil? ? "nil" : value.inspect
          "#{method}: #{value}"
        end.join(", ")
        "#<#{self.class} #{inspection}>"
      end

      private

      def methods_to_inspect
        public_methods - Object.methods - [:parsed_body]
      end
    end
  end
end
