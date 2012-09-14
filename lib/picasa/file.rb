module Picasa
  class File
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
      else
        raise StandarError.new("Content type cannot be guessed from file extension: #{extension}")
      end
    end
  end
end
