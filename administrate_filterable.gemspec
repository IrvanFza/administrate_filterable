
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "administrate_filterable/version"

Gem::Specification.new do |spec|
  spec.name          = "administrate_filterable"
  spec.version       = AdministrateFilterable::VERSION
  spec.authors       = ["Irvan Fauziansyah"]
  spec.email         = ["ervhan@gmail.com"]
  spec.homepage      = 'https://github.com/IrvanFza/administrate_filterable'
  spec.summary       = "Administrate Custom Filter"
  spec.description   = "Simple plugin to add custom filter functionality to your Administrate index page."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug", "~> 10.0"
  spec.add_dependency 'administrate','>= 0.17.0'
  spec.add_dependency 'rails', '>= 4.2'
  spec.add_dependency 'actionview', '>= 5.2.2.1'
  spec.add_dependency 'railties', '>= 5.2.2.1'
end
