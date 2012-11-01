require "minitest/autorun"
require "webmock/minitest"
require "vcr"
require "mocha"

require "picasa"

MultiXml.parser = ENV["XML_PARSER"] || "libxml"

VCR.configure do |c|
  c.cassette_library_dir = "test/cassettes"
  c.hook_into :webmock
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
end
