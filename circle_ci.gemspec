# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'circle_ci_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = 'circle_ci_wrapper'
  spec.version       = CircleCiWrapper::VERSION
  spec.authors       = ['Guilherme Pereira']
  spec.email         = ['guilhermepereira@edgepetrol.com']
  spec.description   = %(CircleCI API wrapper)
  spec.summary       = %(CircleCI API wrapper to help find build artifacts)
  spec.homepage      = 'https://github.com/EdgePetrol/circle_ci'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.4.0'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # General ruby development
  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rubocop', '~> 0.85.1'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-json'
  spec.add_development_dependency 'simplecov-shield-json', '~> 1.0.0'
end
