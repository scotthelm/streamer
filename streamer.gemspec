# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'streamer/version'

Gem::Specification.new do |spec|
  spec.name          = 'streamer'
  spec.version       = Streamer::VERSION
  spec.authors       = ['Scott Helm']
  spec.email         = ['helm.scott@gmail.com']

  spec.summary       = 'streams a hash through a set of configurable functions'
  spec.description   = 'a hash goes in, value comes out'
  spec.homepage      = 'streamer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'ruby_gntp'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'guard-rubocop'
end
