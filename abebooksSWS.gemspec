# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'abebooksSWS/version'

Gem::Specification.new do |gem|
  gem.name        = 'abebooksSWS'
  gem.version     = AbebooksSWS::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ['Diego Marquez']
  gem.email       = ['diego.marquez@papercavalier.com']
  gem.homepage    = 'https://github.com/diegomarquez/abebooksSWS'
  gem.description = 'A wrapper to Abebooks SWS API'
  gem.summary     = 'Abebooks SWS in Ruby'
  gem.license     = 'MIT'

  gem.files         = Dir.glob('lib/**/*') + %w(LICENSE README.md)
  gem.test_files    = Dir.glob('test/**/*')
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'multi_xml', '~> 0.5.0'
  gem.add_runtime_dependency 'excon'

  gem.add_development_dependency 'minitest', '~> 5.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'dotenv'

  gem.required_ruby_version = '>= 2.1.0'
end
