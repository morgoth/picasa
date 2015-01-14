require "picasa/presenter/base"

module Picasa
  module Presenter
    class Exif < Base

      # @return [Float]
      def fstop
        @fstop ||= map_to_float(safe_retrieve(parsed_body, "exif$fstop"))
      end

      # @return [String]
      def make
        @make ||= safe_retrieve(parsed_body, "exif$make")
      end

      # @return [String]
      def model
        @model ||= safe_retrieve(parsed_body, "exif$model")
      end

      # @return [Float]
      def exposure
        @exposure ||= map_to_float(safe_retrieve(parsed_body, "exif$exposure"))
      end

      # @return [Boolean]
      def flash
        @flash ||= map_to_boolean(safe_retrieve(parsed_body, "exif$flash"))
      end

      # @return [Float]
      def focal_length
        @focal_length ||= map_to_float(safe_retrieve(parsed_body, "exif$focallength"))
      end

      # @return [Integer]
      def iso
        @iso ||= map_to_integer(safe_retrieve(parsed_body, "exif$iso"))
      end

      # @return [DateTime]
      def time
        @time ||= begin
          if value = safe_retrieve(parsed_body, "exif$time")
            DateTime.strptime((value.to_f / 1000).round.to_s, '%s')
          end
        end
      end

      # @return [String]
      def image_unique_id
        @image_unique_id ||= safe_retrieve(parsed_body, "exif$imageUniqueID")
      end
    end
  end
end
