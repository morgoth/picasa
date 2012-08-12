# -*- encoding: utf-8 -*-
require File.expand_path('../lib/picasa/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Wojciech Wnętrzak"]
  gem.email = ["w.wnetrzak@gmail.com"]
  gem.description = %q{Simple Google Picasa managment}
  gem.summary = %q{simple google picasa managment}
  gem.homepage = "https://github.com/morgoth/picasa"

  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name = "picasa"
  gem.require_paths = ["lib"]
  gem.version = Picasa::VERSION

  gem.add_dependency "multi_xml"

  gem.add_development_dependency "webmock"
  gem.add_development_dependency "mocha"
end
