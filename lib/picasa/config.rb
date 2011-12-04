require "singleton"

module Picasa
  class Config
    include Singleton
    attr_accessor :user_id

    # TODO: remove google_user
    alias :google_user :user_id
    alias :"google_user=" :"user_id="
  end

  def self.config
    if block_given?
      yield Config.instance
    end
    Config.instance
  end
end
