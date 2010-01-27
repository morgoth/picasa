require 'test_helper'

class ConfigTest < Test::Unit::TestCase
  test "Not raise argument error if google user is set by configuration block" do
    Picasa.config do |c|
      c.google_user = 'some.user'
    end
    assert_nothing_raised do
      Picasa::WebAlbums.new(nil)
    end
  end

  test "Take user passed to method instead of config" do
    Picasa.config do |c|
      c.google_user = 'some.user'
    end
    assert_equal 'some.user', Picasa.config.google_user
    Picasa::WebAlbums.new('important.user')
    assert_equal 'important.user', Picasa.config.google_user
  end
end