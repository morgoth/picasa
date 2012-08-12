module Picasa
  module Utils
    def safe_retrieve(hash, *keys)
      return if !hash.kind_of?(Hash) || !hash.has_key?(keys.first)

      if keys.size == 1
        hash[keys.first]
      elsif keys.size > 1
        Utils.safe_retrieve(hash[keys.first], *keys[1..-1])
      end
    end

    module_function :safe_retrieve
  end
end
