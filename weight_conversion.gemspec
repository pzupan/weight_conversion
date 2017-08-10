# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weight_conversion/version'

Gem::Specification.new do |spec|
  spec.name          = "weight_conversion"
  spec.version       = WeightConversion::VERSION
  spec.authors       = ["Paul Zupan"]
  spec.email         = ["pzupan@gmail.com"]
  spec.summary       = %q{Gem to convert measures of weight.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "config"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"

end
