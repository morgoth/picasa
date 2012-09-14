require "helper"

describe Picasa::File do
  it "raises argument error when nil path given" do
    assert_raises Picasa::ArgumentError do
      Picasa::File.new(nil)
    end
  end

  it "it returns file name" do
    file = Picasa::File.new(image_path("lena.jpg"))
    assert_equal "lena", file.name
  end

  it "it returns file extension" do
    file = Picasa::File.new(image_path("lena.jpg"))
    assert_equal "jpg", file.extension
  end

  it "it guesses content type" do
    file = Picasa::File.new(image_path("lena.jpg"))
    assert_equal "image/jpeg", file.content_type
  end

  it "returns binary read file" do
    file = Picasa::File.new(image_path("lena.jpg"))
    assert_equal String, file.binary.class
  end
end
