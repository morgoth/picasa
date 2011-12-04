require "minitest/autorun"
require "fakeweb"

require "picasa"

class MiniTest::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
  end

  def fixture_file(filename)
    return "" if filename == ""
    file_path = File.expand_path(File.dirname(__FILE__) + "/fixtures/" + filename)
    File.read(file_path)
  end
end
