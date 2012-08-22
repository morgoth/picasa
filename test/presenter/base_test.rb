# -*- encoding: utf-8 -*-
require "helper"

class TestPresenter < Picasa::Presenter::Base
  def body
    parsed_body[:body]
  end

  def nil_value
    nil
  end
end

describe Picasa::Presenter::Base do
  before do
    @presenter = TestPresenter.new({:body => "presented body"})
  end

  it "has parsed_body" do
    assert_equal @presenter.parsed_body, {:body => "presented body"}
  end

  it "has inspect with class name and defined methods" do
    expected = %q{#<TestPresenter body: "presented body", nil_value: nil>}
    assert_equal expected, @presenter.inspect
  end
end
