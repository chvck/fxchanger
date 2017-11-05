
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fxchanger/version"

Gem::Specification.new do |spec|
  spec.name          = "fxchanger"
  spec.version       = Fxchanger::VERSION
  spec.authors       = ["chvck"]
  spec.email         = ["chvckd@gmail.com"]

  spec.summary       = %q{Library for converting between exchange rates.}
  spec.homepage      = ""

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "sequel", "~> 5.2"
  spec.add_development_dependency "gem_config", "~> 0.3.1"
  spec.add_development_dependency "faraday", "~> 0.13.1"
  spec.add_development_dependency "webmock", "~> 3.1"
end
