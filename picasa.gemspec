# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{picasa}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wojciech Wn\304\231trzak"]
  s.date = %q{2009-05-20}
  s.email = %q{w.wnetrzak@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "lib/picasa.rb",
     "test/fixtures/albums",
     "test/fixtures/photos",
     "test/picasa_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/morgoth/picasa}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{simple google picasa managment}
  s.test_files = [
    "test/picasa_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<xml-simple>, [">= 0"])
    else
      s.add_dependency(%q<xml-simple>, [">= 0"])
    end
  else
    s.add_dependency(%q<xml-simple>, [">= 0"])
  end
end
