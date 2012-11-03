# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sports_data_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Lovelett"]
  gem.email         = ["ryan@lovelett.me"]
  gem.description   = %q{A Ruby interface to the Sports Data API.}
  gem.summary       = %q{SportsData’s comprehensive data coverage includes all major U.S. sports, plus hundreds of leagues throughout the world. Their live game analysts capture every possible event of every game, in real time and with accuracy standards developed from years of experience.}
  gem.homepage      = "https://github.com/RLovelett/sports_data_api"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sports_data_api"
  gem.require_paths = ["lib"]
  gem.version       = SportsDataApi::VERSION

  gem.add_dependency "nokogiri", "~> 1.5.5"
  gem.add_dependency "rest-client", "~> 1.6.7"

  gem.add_development_dependency "rspec", "~> 2.11.0"
  gem.add_development_dependency "rspec-xml", "~> 0.0.6"
  gem.add_development_dependency "guard-rspec", "~> 2.1.0"
  gem.add_development_dependency "rb-fsevent", "~> 0.9.1"
  gem.add_development_dependency "growl", "~> 1.0.3"
  gem.add_development_dependency "terminal-notifier-guard", "~> 1.5.3"
  gem.add_development_dependency "faker", "~> 1.1.2"
end
