require "yaml"
require "zlib"
require "multi_json"

require "minitest/autorun"
require "webmock/minitest"
require "vcr"
require "mocha/setup"

require "picasa"

AuthHeader = ENV["PICASA_ACCESS_TOKEN"] || "GoogleLogin auth=token"

MultiJson.adapter = ENV["JSON_PARSER"] || "oj"

VCR.configure do |c|
  c.cassette_library_dir = "test/cassettes"
  c.hook_into :webmock
  c.default_cassette_options = {preserve_exact_body_bytes: true}
  c.filter_sensitive_data("<FILTERED>") { AuthHeader }
end

class MiniTest::Test
  def setup
    WebMock.disable_net_connect!
  end

  def fixture_path(filename)
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
