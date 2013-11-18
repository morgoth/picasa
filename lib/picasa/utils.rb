require "date"
require "cgi"

module Picasa
  module Utils
    def safe_retrieve(hash, *keys)
      result = retrieve(hash, keys)
      if result.kind_of?(Hash) && result.has_key?('$t') && result.keys.size == 1
        result['$t']
      else
        result
      end
    end

    def retrieve(hash, keys)
      return if !hash.kind_of?(Hash) || !hash.has_key?(keys.first)

      if keys.size == 1
        hash[keys.first]
      elsif keys.size > 1
        Utils.retrieve(hash[keys.first], keys[1..-1])
      end
    end

    # Ported from activesupport gem
    def array_wrap(object)
      if object.nil?
        []
      elsif object.respond_to?(:to_ary)
        object.to_ary || [object]
      else
        [object]
      end
    end

    def map_to_integer(value)
      value && value.to_i
    end

    def map_to_date(value)
      value && DateTime.parse(value)
    end

    def map_to_boolean(value)
      return unless value
      case value
        when "true"  then true
        when "false" then false
      end
    end

    def inline_query(query)
      query.map do |key, value|
        dasherized = key.to_s.gsub("_", "-")
        "#{CGI.escape(dasherized)}=#{CGI.escape(value.to_s)}"
      end.join("&")
    end

    module_function :safe_retrieve, :retrieve, :array_wrap, :map_to_integer, :map_to_boolean, :map_to_date, :inline_query
  end
end
