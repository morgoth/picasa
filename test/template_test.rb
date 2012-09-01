require "helper"

describe Picasa::Template do
  it "has name" do
    template = Picasa::Template.new(:new_album, {})
    assert_equal :new_album, template.name
  end

  it "has params" do
    template = Picasa::Template.new(:new_album, {:title => "My album"})
    assert_equal({:title => "My album"}, template.params)
  end

  describe "new_album" do
    it "renders title" do
      template = Picasa::Template.new(:new_album, {:title => "My album"})
      assert_match %q{<title type="text">My album</title>}, template.render
    end

    it "renders summary" do
      template = Picasa::Template.new(:new_album, {:summary => "My summary"})
      assert_match %q{<summary type="text">My summary</summary>}, template.render
    end
  end
end
