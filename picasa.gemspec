# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "picasa/version"

Gem::Specification.new do |spec|
  spec.name          = "picasa"
  spec.version       = Picasa::VERSION
  spec.authors       = ["Wojciech Wnętrzak"]
  spec.email         = ["w.wnetrzak@gmail.com"]
  spec.description   = %q{Ruby client for Google Picasa API}
  spec.summary       = %q{Simple Google Picasa managment}
  spec.homepage      = "https://github.com/morgoth/picasa"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_dependency "httparty"

  spec.add_development_dependency "bundler", ">= 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", ">= 5.0.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "mocha", ">= 0.13.0"
  spec.add_development_dependency "vcr", ">= 2.4.0"

  spec.post_install_message = "Authenticating by providing password is no longer possible due to google API shutdown https://developers.google.com/accounts/docs/AuthForInstalledApps You need to set `access_token` for authenticated requests now."
end
