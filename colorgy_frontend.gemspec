# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'colorgy_frontend/version'

Gem::Specification.new do |spec|
  spec.name          = "colorgy_frontend"
  spec.version       = ColorgyFrontend::VERSION
  spec.authors       = ["Neson"]
  spec.email         = ["neson@dex.tw"]
  spec.summary       = %q{The front-end framework used for colorgy.}
  spec.description   = %q{The front-end framework used for colorgy.}
  spec.homepage      = ""
  spec.license       = "AGPL-3.0"

  spec.files         = Dir["{lib,vendor}/**/*"] + ["README.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "compass"
  spec.add_dependency "jquery-rails", ">= 3.1.2"
  spec.add_dependency "modernizr-rails"
end
