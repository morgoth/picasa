require "minitest/autorun"
require "fakeweb"
require "mocha"

require "picasa"

MultiXml.parser = :ox

class MiniTest::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
  end

  # Recording response is as simple as writing in terminal:
  # curl -is -H "GData-Version: 2" "https://picasaweb.google.com/data/feed/api/user/username?prettyprint=true" -X GET > test/fixtures/albums.txt
  def fixture(filename)
    File.read(File.join("test", "fixtures", filename))
  end
end
