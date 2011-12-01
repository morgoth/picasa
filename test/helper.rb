gem "test-unit"
require "test/unit"
require "fakeweb"

require "picasa"

def fixture_file(filename)
  return "" if filename == ""
  file_path = File.expand_path(File.dirname(__FILE__) + "/fixtures/" + filename)
  File.read(file_path)
end
