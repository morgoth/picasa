require "yaml"
require "zlib"

require "minitest/autorun"
require "webmock/minitest"
require "vcr"
require "mocha"

require "picasa"

MultiXml.parser = ENV["XML_PARSER"] || "libxml"

AuthHeader = ENV["PICASA_AUTH_HEADER"] || "GoogleLogin auth=token"

VCR.configure do |c|
  c.cassette_library_dir = "test/cassettes"
  c.hook_into :webmock
  c.default_cassette_options = {:serialize_with => :syck} # Avoid stroing headers as binary
  c.filter_sensitive_data("<FILTERED>") { AuthHeader }
end

class MiniTest::Unit::TestCase
  def setup
    WebMock.disable_net_connect!
  end

  def image_path(filename)
    File.join("test", "fixtures", filename)
  end

  # Recording response is as simple as writing in terminal:
  # curl -is -H "GData-Version: 2" "https://picasaweb.google.com/data/feed/api/user/username?prettyprint=true" -X GET > test/fixtures/albums.txt
  def fixture(filename)
    File.read(File.join("test", "fixtures", filename))
  end

  # Retrieves gzipped body
  def decode(cassette_name)
    cassette = YAML.load_file(File.join("test", "cassettes", cassette_name))
    gzipped_body = cassette["http_interactions"][0]["response"]["body"]["string"]
    body_io = StringIO.new(gzipped_body)
    Zlib::GzipReader.new(body_io).read
  end
end
