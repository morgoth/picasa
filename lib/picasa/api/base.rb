module Picasa
  module API
    class Base
      attr_reader :user_id, :authorization_header

      # @param [Hash] credentials
      # @option credentials [String] :user_id google username/email
      # @option credentials [String] :authorization_header header for authenticating requests
      def initialize(credentials = {})
        @user_id  = credentials.fetch(:user_id)
        @authorization_header = credentials[:authorization_header]
      end

      def auth_header
        {}.tap do |header|
          header["Authorization"] = authorization_header if authorization_header
        end
      end
    end
  end
end
