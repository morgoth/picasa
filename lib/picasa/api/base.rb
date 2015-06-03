module Picasa
  module API
    class Base
      attr_reader :user_id, :authorization_header, :access_token

      # @param [Hash] credentials
      # @option credentials [String] :user_id google username/email
      # @option credentials [String] :access_token token for authorizing requests
      def initialize(credentials = {})
        @user_id  = credentials.fetch(:user_id)
        @access_token = credentials[:access_token]
        @authorization_header = credentials[:authorization_header]
      end

      def auth_header
        {}.tap do |header|
          token = if access_token
            "Bearer #{access_token}"
          elsif authorization_header
            authorization_header
          end

          header["Authorization"] = token if token
        end
      end
    end
  end
end
