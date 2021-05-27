# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)
require "abebooks/version"

Gem::Specification.new do |gem|
  gem.name = "abebooks"
  gem.version = Abebooks::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.authors = ["Diego Marquez"]
  gem.email = ["marquez.diego.e@gmail.com"]
  gem.homepage = "https://github.com/diegomarquez/abebooks"
  gem.summary = "A Ruby wrapper to the Abebooks SWS API"
  gem.license = "MIT"

  gem.files = Dir.glob("lib/**/*") + %w[LICENSE README.md]
  gem.test_files = Dir.glob("test/**/*")
  gem.require_paths = ["lib"]

  gem.add_dependency "http", "~> 5.0"
  gem.add_dependency "ox", "~> 2.0"
  gem.add_development_dependency "minitest"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "standardrb"

  gem.required_ruby_version = ">= 2.6"
end
