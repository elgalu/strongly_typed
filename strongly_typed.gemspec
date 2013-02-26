# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'strongly_typed/version'

Gem::Specification.new do |gem|

  gem.platform      = Gem::Platform::RUBY
  gem.name          = "strongly_typed"
  gem.version       = StronglyTyped::VERSION
  gem.summary       = %q{Simple type validation for plain ruby object attributes that perform conversions whenever possible.}
  gem.description   = gem.summary

  gem.required_ruby_version     = '>= 1.9.2'
  gem.required_rubygems_version = '>= 1.8'

  gem.license       = 'MIT'

  gem.authors       = ["Leo Gallucci"]
  gem.email         = ["elgalu3@gmail.com"]
  gem.homepage      = "https://github.com/elgalu/strongly_typed"

  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "boolean_class", "~> 0.0"

  gem.add_development_dependency "bundler", ">= 1.2"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.13"
  gem.add_development_dependency "redcarpet", "~> 2.2"
  gem.add_development_dependency "yard", "~> 0.8"
  gem.add_development_dependency "simplecov", "~> 0.7"

end
