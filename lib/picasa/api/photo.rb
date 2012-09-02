module Picasa
  module API
    class Photo
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

      # Creates photo for given album
      #
      # @param [String] album_id album id
      # @param [Hash] options request parameters
      # @option options [String] :title title of album (required)
      # @option options [String] :summary summary of album
      def create(album_id, params = {})
        params[:binary] || raise(ArgumentError, "You must specify binary")
        params[:content_type] || raise(ArgumentError, "You must specify image content_type")
        params[:boundary] ||= "===============PicasaRubyGem=="
        template = Template.new(:new_photo, params)
        headers = {"Content-Type" => "multipart/related; boundary=\"#{params[:boundary]}\""}

        uri = URI.parse("/data/feed/api/user/#{user_id}/albumid/#{album_id}")
        parsed_body = Connection.new(credentials).post(uri.path, template.render, headers)
        Presenter::Photo.new(parsed_body["entry"])
      end
    end
  end
end
