# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'caterpillar-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "caterpillar-ruby"
  spec.version       = Caterpillar::VERSION
  spec.authors       = ["Nitish Sharma", "Nishit Hirani"]
  spec.email         = ["nitish.sharma@keepworks.com", "nishit@keepworks.com"]

  spec.summary       = %q{A simple ruby client for the Caterpillar API}
  spec.description   = %q{Easily convert HTML to PDF in your Ruby app using Caterpillar API.}
  spec.homepage      = "https://caterpillar.io"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "https://rubygems.org/"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "httparty"
end
