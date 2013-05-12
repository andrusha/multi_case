# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "multi_case"

Gem::Specification.new do |s|
  s.name        = MultiCase::PACKAGE
  s.version     = MultiCase::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrey Korzhuev"]
  s.email       = ["andrew@korzhuev.com"]
  s.homepage    = "https://github.com/andrusha/multi_case"
  s.summary     = %q{Multi-parameter case statement}
  s.description = %q{A state-machine inspired case/if statement}

  s.rubyforge_project = "multi_case"

  s.files         = `git ls-files -z`.split("\0")
  s.test_files    = `git ls-files -z -- {fixtures,features,spec}/*`.split("\0")
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
end
