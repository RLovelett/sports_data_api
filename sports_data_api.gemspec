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
end
