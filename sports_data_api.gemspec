# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sports_data_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Ryan Lovelett', 'Trevor John']
  gem.email         = ['ryan@lovelett.me', 'Trevor@John.tj']
  gem.description   = %q{A Ruby interface to the Sportradar API.}
  gem.summary       = %q{Sportradar’s comprehensive data coverage includes all major U.S. sports, plus hundreds of leagues throughout the world. Their live game analysts capture every possible event of every game, in real time and with accuracy standards developed from years of experience.}
  gem.homepage      = 'https://github.com/RLovelett/sports_data_api'
  gem.licenses      = ['MIT']

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'sports_data_api'
  gem.require_paths = %w{lib}
  gem.version       = SportsDataApi::VERSION

  gem.add_dependency 'nokogiri', '>= 1.5'
  gem.add_dependency 'rest-client', '>= 1.8'
  gem.add_dependency 'multi_json', '>= 1.11'

  gem.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake', '>= 11.0'
  gem.add_development_dependency 'rb-fsevent', '~> 0.9'
  gem.add_development_dependency 'rspec', '~> 3.5'
  gem.add_development_dependency 'rspec-collection_matchers', '~> 1.1'
  gem.add_development_dependency 'rspec-its', '~> 1.2'
  gem.add_development_dependency 'rspec-xml', '~> 0.1'
  gem.add_development_dependency 'simplecov', '~> 0.13'
  gem.add_development_dependency 'vcr', '~> 3.0'
  gem.add_development_dependency 'webmock', '~> 2.3'
end
