# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloudcoverage/version'

Gem::Specification.new do |spec|
  spec.name          = "cloudcoverage"
  spec.version       = Cloudcoverage::VERSION
  spec.authors       = ["Vladimir Moravec"]
  spec.email         = ["vmoravec@suse.com"]

  spec.summary       = %q{Lorem ipsum}
  spec.description   = %q{Loperm ipusm}
  spec.homepage      = "https://gitlab.suse.de/qa/cloudcoverage"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "sinatra", "~> 1.4"
  spec.add_dependency "sinatra-export", "~> 1.0"
  spec.add_dependency "slim", "~> 3.0"
  spec.add_dependency "sprockets", "~> 3.7"
  spec.add_dependency "sass", "~> 3.4"
  spec.add_dependency "awesome_print", "~> 1.6"
end
