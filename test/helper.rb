require "yaml"
require "zlib"

require "minitest/autorun"
require "webmock/minitest"
require "vcr"
require "mocha"

require "picasa"

AuthHeader = ENV["PICASA_AUTH_HEADER"] || "GoogleLogin auth=token"
Password   = ENV["PICASA_PASSWORD"]    || "secret"

VCR.configure do |c|
  c.cassette_library_dir = "test/cassettes"
  c.hook_into :webmock
  c.default_cassette_options = {:serialize_with => :syck, :preserve_exact_body_bytes => true} # Avoid stroing headers as binary
  c.filter_sensitive_data("<FILTERED>") { AuthHeader }
  c.filter_sensitive_data("<FILTERED>") { Password }
end

class MiniTest::Unit::TestCase
  def setup
    WebMock.disable_net_connect!
  end

  def image_path(filename)
    File.join("test", "fixtures", filename)
  end

  # Retrieves gzipped body
  def decode(cassette_name)
    cassette = YAML.load_file(File.join("test", "cassettes", cassette_name))
    gzipped_body = cassette["http_interactions"][0]["response"]["body"]["string"]
    body_io = StringIO.new(gzipped_body)
    Zlib::GzipReader.new(body_io).read
  end
end
