require "minitest/autorun"
require "fakeweb"

require "picasa"

class MiniTest::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
  end

  # Recording response is as simple as writing in terminal:
  # curl -is -H "GData-Version: 2" https://picasaweb.google.com/data/feed/api/user/username -X GET > test/fixtures/albums.txt
  def fixture_file(filename)
    file_path = File.expand_path(File.dirname(__FILE__) + "/fixtures/" + filename)
    File.read(file_path)
  end
end
