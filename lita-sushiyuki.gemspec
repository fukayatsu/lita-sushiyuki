# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lita/sushiyuki/version'

Gem::Specification.new do |spec|
  spec.name          = "lita-sushiyuki"
  spec.version       = Lita::Sushiyuki::VERSION
  spec.authors       = ["fukayatsu"]
  spec.email         = ["fukayatsu@gmail.com"]
  spec.summary       = %q{Give me sushi}
  spec.description   = %q{Give me sushi}
  spec.homepage      = "https://github.com/fukayatsu/lita-sushiyuki"
  spec.license       = "MIT"

  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 3.1"
  spec.add_runtime_dependency 'pebbles-suddenly_death_string', '~> 0.0.4'
  spec.add_runtime_dependency 'flippy', '~> 0.1.2'
  spec.add_runtime_dependency 'rufus-scheduler', '~> 3.0.7'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
