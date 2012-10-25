#!/usr/bin/env rake
require "bundler/gem_tasks"

require "rake/testtask"
Rake::TestTask.new(:test) do |test|
  test.libs << "lib" << "test"
  test.pattern = "test/**/*_test.rb"
  test.verbose = true
end

def curl(url, filename, include_headers = false)
  headers = "i" if include_headers
  system %{/usr/bin/curl -#{headers}s -H "GData-Version: 2" "#{url}" -X GET -o #{filename}}
end

namespace :test do
  desc "Create fixtures files"
  task :create_fixtures do
    curl "https://picasaweb.google.com/data/feed/api/user/106136347770555028022?v=2&alt=json&prettyprint=true", "test/fixtures/presenters/album_list.json"

    curl "https://picasaweb.google.com/data/feed/api/user/106136347770555028022?v=2&alt=json&kind=tag&prettyprint=true", "test/fixtures/presenters/tag_list.json"

    curl "https://picasaweb.google.com/data/feed/api/user/106136347770555028022/albumid/5239555770355467953?v=2&alt=json&prettyprint=true", "test/fixtures/presenters/album_show.json"

    curl "https://picasaweb.google.com/data/feed/api/user/106136347770555028022?v=2&alt=json&kind=comment&prettyprint=true", "test/fixtures/presenters/comment_list.json"

    curl "https://picasaweb.google.com/data/feed/api/user/104662451283465127832/albumid/5631443706739061905?v=2&alt=json&prettyprint=true", "test/fixtures/presenters/album_show_with_one_photo.json"
  end
end

task :default => :test
