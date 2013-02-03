module Picasa
  class File
    KnownExtensions = %w{jpg jpeg png gif bmp 3gp mp4 mpeg mov wmv asf avi}

    class Null
      def path; end
      def name; end
      def extension; end
      def binary; end
      def content_type; end
    end

    attr_reader :path

    def initialize(path)
      @path = path || raise(ArgumentError.new("path not specified"))
    end

    def name
      @name ||= ::File.basename(path, ".*")
    end

    def extension
      @extension ||= ::File.extname(path)[1..-1]
    end

    def binary
      @binary ||= ::File.open(path, "rb").read
    end

    def content_type
      @content_type ||= case extension
      when /^jpe?g$/i
        "image/jpeg"
      when /^gif$/i
        "image/gif"
      when /^png$/i
        "image/png"
      when /^bmp$/i
        "image/bmp"
      # Videos
      when /^3gp$/i
        "video/3gpp"
      when /^mp4$/i
        "video/mp4"
      when /^mpeg$/i
        "video/mpeg"
      when /^mov$/i
        "video/quicktime"
      when /^wmv$/i
        "video/x-ms-wmv"
      when /^asf$/i
        "video/x-ms-asf"
      when /^avi$/i
        "video/avi"
      else
        raise UnknownContentType.new("Content type cannot be guessed from file extension: #{extension}")
      end
    end
  end
end
