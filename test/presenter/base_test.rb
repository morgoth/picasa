# -*- encoding: utf-8 -*-
require "helper"

class TestAttributePresenter < Picasa::Presenter::Base
  def attribute
    parsed_body[:attribute]
  end
end

class TestNilAttributePresenter < Picasa::Presenter::Base
  def nil_attribute
    nil
  end
end

class TestEntriesAliasPresenter < Picasa::Presenter::Base
  def entries
    ["entries"]
  end
  alias :elements :entries
end

describe Picasa::Presenter::Base do
  it "has attribute" do
    presenter = TestAttributePresenter.new({:attribute => "presented body"})

    assert_equal presenter.parsed_body, {:attribute => "presented body"}
  end

  it "has inspect with class name and defined attribute" do
    presenter = TestAttributePresenter.new({:attribute => "presented body"})
    expected = %q{#<TestAttributePresenter attribute: "presented body">}

    assert_equal expected, presenter.inspect
  end

  it "has inspect with nil attribute" do
    presenter = TestNilAttributePresenter.new({:attribute => "presented body"})
    expected = %q{#<TestNilAttributePresenter nil_attribute: nil>}

    assert_equal expected, presenter.inspect
  end

  it "has aliased method to entries" do
    presenter = TestEntriesAliasPresenter.new({:attribute => "presented body"})
    expected = %q{#<TestEntriesAliasPresenter elements: ["entries"]>}

    assert_equal expected, presenter.inspect
  end
end
