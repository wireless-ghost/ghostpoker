# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ghostpoker/version'

Gem::Specification.new do |spec|
  spec.name          = "ghostpoker"
  spec.version       = Ghostpoker::VERSION
  spec.authors       = ["Veselin Rusinov"]
  spec.email         = ["v.russinov@gmail.com"]
  spec.summary       = %q{Multiplayer console/GUI Texas Hold 'Em Poker}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "gosu"
  spec.add_development_dependency "awesome_print"
end
