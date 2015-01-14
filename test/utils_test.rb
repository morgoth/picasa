# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Utils do
  describe "#safe_retrieve" do
    it "returns nested hash value" do
      hash = {:first => {:second => {:third => "Value!"}}}
      assert_equal "Value!", Picasa::Utils.safe_retrieve(hash, :first, :second, :third)
    end

    it "returns partial hash when not all keys given" do
      hash = {:first => {:second => {:third => "Value!"}}}
      assert_equal({:third =>  "Value!"}, Picasa::Utils.safe_retrieve(hash, :first, :second))
    end

    it "returns nil when key not found in hash" do
      hash = {:first => {:second => {:third => "Value!"}}}
      assert_nil Picasa::Utils.safe_retrieve(hash, :non_exisiting)
    end

    it "returns nil when one of keys not found in hash" do
      hash = {:first => {:second => {:third => "Value!"}}}
      assert_nil Picasa::Utils.safe_retrieve(hash, :first, :non_exisiting)
    end

    it "returns nil when given more keys than present in hash" do
      hash = {:first => {:second => {:third => "Value!"}}}
      assert_nil Picasa::Utils.safe_retrieve(hash, :first, :second, :third, :fourth)
    end

    it "returns nil when non hash object given" do
      assert_nil Picasa::Utils.safe_retrieve("And Now for Something Completely Different")
    end

    it "returns nil when no keys given" do
      hash = {:first => {:second => {:third => "Value!"}}}
      assert_nil Picasa::Utils.safe_retrieve(hash)
    end

    it "does not return incidental value" do
      hash = {nil => "value"}
      assert_nil Picasa::Utils.safe_retrieve(hash)
    end
  end

  describe "#array_wrap" do
    it "wraps hash into array" do
      assert_equal [{:wt => :f}], Picasa::Utils.array_wrap({:wt => :f})
    end
  end

  describe "#map_to_integer" do
    it "does not convert nil value" do
      assert_nil Picasa::Utils.map_to_integer(nil)
    end

    it "converts given value to integer" do
      assert_equal 101, Picasa::Utils.map_to_integer("101")
    end
  end

  describe "#map_to_float" do
    it "does not convert nil value" do
      assert_nil Picasa::Utils.map_to_float(nil)
    end

    it "converts given value to float" do
      assert_in_delta 101.123, Picasa::Utils.map_to_float("101.123")
    end
  end


  describe "#map_to_date" do
    it "does not convert nil value" do
      assert_nil Picasa::Utils.map_to_date(nil)
    end

    it "converts given value to date" do
      assert_equal DateTime, Picasa::Utils.map_to_date("2008-09-08T07:00:00+00:00").class
    end
  end

  describe "#map_to_boolean" do
    it "converts true string to boolean" do
      assert_equal true, Picasa::Utils.map_to_boolean("true")
    end

    it "converts false string to boolean" do
      assert_equal false, Picasa::Utils.map_to_boolean("false")
    end

    it "does not convert other values" do
      assert_nil Picasa::Utils.map_to_boolean("truthy")
    end
  end

  describe "#inline_query" do
    it "converts params to inline style" do
      params = Picasa::Utils.inline_query({:alt => "json", :kind => "photo"})
      # make ruby 1.8 tests pass
      assert_equal "alt=json", params.split("&").sort[0]
      assert_equal "kind=photo", params.split("&").sort[1]
    end

    it "changes param keys underscore to dash" do
      params = Picasa::Utils.inline_query({:max_results => 10})
      assert_equal "max-results=10", params
    end

    it "escapes values" do
      params = Picasa::Utils.inline_query({:kind => "żółć"})
      assert_equal "kind=%C5%BC%C3%B3%C5%82%C4%87", params
    end
  end
end
