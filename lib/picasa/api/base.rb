module Picasa
  module API
    class Base
      attr_reader :user_id, :credentials

      # @param [Hash] credentials
      # @option credentials [String] :user_id google username/email
      # @option credentials [String] :password password for given username/email
      def initialize(credentials)
        if MultiXml.parser.to_s == "MultiXml::Parsers::Ox"
          raise StandardError, "MultiXml parser is set to :ox - picasa gem will not work with it currently, use one of: :libxml, :nokogiri, :rexml"
        end
        @user_id  = credentials.fetch(:user_id)
        @credentials = credentials
      end
    end
  end
end
