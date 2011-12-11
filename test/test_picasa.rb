require "helper"

describe Picasa do
  it "should allow to set custom user_id" do
    Picasa.configure do |config|
      config.user_id = "john.doe"
    end

    assert_equal "john.doe", Picasa.user_id
  end

  describe "Albums" do
    before do
      @options  = {:user_id => "Bram"}
      @albums   = Picasa::Album.new @options[:user_id]
    end

    it "Lists all the albums" do
      Picasa::Album.any_instance.expects(:list).with(@options).returns(@albums)
      assert_equal @albums, Picasa.albums(@options)
    end

    it "Is backward compatiable" do
      @options = {:google_user => @options[:user_id]}

      Picasa::Album.any_instance.expects(:list).with(@options).returns(@albums)
      assert_equal @albums, Picasa.albums(@options)
    end

    it "Allows nillable options" do
      Picasa::Album.any_instance.expects(:list).returns(@albums)
      assert_equal @albums, Picasa.albums
    end
  end

  describe "Photos" do
    before do
      @options  = {:user_id => "Bram", :album_id => "123"}
      @albums   = Picasa::Album.new @options[:user_id]
    end

    it "Lists all the albums" do
      Picasa::Album.any_instance.expects(:show).with("123", {:user_id =>"Bram"}).returns(@albums)
      assert_equal @albums, Picasa.photos(@options)
    end

    it "Is backward compatiable" do
      @options = {:google_user => @options[:user_id], :album_id => "123"}

      Picasa::Album.any_instance.expects(:show).with("123", {:user_id =>"Bram"}).returns(@albums)
      assert_equal @albums, Picasa.photos(@options)
    end

    it "Raises Argument error when no album id is supplied" do
      assert_raises(ArgumentError) do
        Picasa.photos
      end
    end
  end
end
