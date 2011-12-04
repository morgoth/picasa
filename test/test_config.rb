require "helper"

describe Picasa::Config do
  it "should take user passed to method instead of config" do
    Picasa.config do |c|
      c.google_user = "some.user"
    end
    assert_equal "some.user", Picasa.config.google_user
    Picasa::WebAlbums.new("important.user")
    assert_equal "important.user", Picasa.config.google_user
  end
end
