require "ostruct"
require "erb"

module Picasa
  class Template
    attr_reader :name, :params

    def initialize(name, params)
      @name   = name
      @params = params
    end

    def file
      @file ||= IO.read(::File.expand_path("../templates/#{name}.xml.erb", __FILE__))
    end

    def struct
      @struct ||= OpenStruct.new(params)
    end

    def render
      ERB.new(file).result(struct.instance_eval { binding })
    end
  end
end
