require "./picasa/api/base"

module Picasa
  module API
    class Tag < Base
      # Returns tag list - when album_id is not specified, list of user tags will be returned
      #
      # @param [Hash] options additional options included in request
      # @option options [String] :album_id retrieve tags for given album
      # @option options [String] :photo_id retrieve tags for given photo (album_id must be provided)
      #
      # @return [Presenter::TagList]
      def list(options = {})
        album_id = options[:album_id]
        photo_id = options[:photo_id]
        raise(ArgumentError, "You must specify album_id when providing photo_id") if photo_id && !album_id

        path = "/data/feed/api/user/#{user_id}"
        path << "/albumid/#{album_id}" if album_id
        path << "/photoid/#{photo_id}" if photo_id

        uri = URI.parse(path)

        parsed_body = Connection.new(credentials).get(uri.path, options.merge(:kind => "tag"))

        Presenter::TagList.new(parsed_body["feed"])
      end

	  # Adding a tag to a photo.
	  #
	  # @param [Hash]
	  # @option options [String] :album_id
	  # @option options [String] :photo_id
	  # @option options [String] :tag_name
	  # @return [Presenter::Photo]
	  def add(params = {})
	    album_id = params[:album_id]
		photo_id = params[:photo_id]
		tag_name = params[:tag_name]
		raise(ArgumentError, "You must specify album_id when providing photo_id") if photo_id && !album_id
		raise(ArgumentError, "You must specify adding tag name") if !tag_name
		
		path = "/data/feed/api/user/#{user_id}"
		path << "/albumid/#{album_id}" if album_id
		path << "/photoid/#{photo_id}" if photo_id
		
		template = Template.new("adding_tag", {:tag_name => tag_name})
		
		uri = URI.parse(path)
		parsed_body = Connection.new(credentials).post(uri.path, template.render)
		Presenter::Photo.new(parsed_body["entry"])
	  end

    end
  end
end
