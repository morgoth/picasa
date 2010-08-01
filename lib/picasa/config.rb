require 'singleton'

module Picasa
  class Config
    include Singleton
    attr_accessor :google_user
  end

  def self.config
    if block_given?
      yield Config.instance
    end
    Config.instance
  end
end
