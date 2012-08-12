module Picasa
  # All Picasa exceptions can be cought by rescuing:
  # Picasa::StandardError
  #
  class StandardError < StandardError; end

  class ArgumentError < StandardError; end

  class ResponseError < StandardError
    attr_reader :response

    def initialize(message, response)
      @response = response
      super(message)
    end
  end
end
