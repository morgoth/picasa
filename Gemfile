source "https://rubygems.org"

gemspec

gem "multi_json", "1.3.7" # https://github.com/intridea/multi_json/pull/74
gem "rake"
gem "minitest", "3.5.0", :platform => :ruby_18

group :extra do
  gem "thor"
  gem "debugger", :platform => :ruby_19 if RUBY_VERSION < "2.0"
end

# JSON parsers
gem "oj"
gem "yajl-ruby"
gem "json_pure"
