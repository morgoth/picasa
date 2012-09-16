require "minitest/autorun"
require "webmock/minitest"
require "mocha"

require "picasa"

xml_parser = ENV["XML_PARSER"] || "libxml"

require xml_parser if ["nokogiri", "libxml", "ox"].include?(xml_parser)
MultiXml.parser = xml_parser

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
