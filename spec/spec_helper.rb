require 'simplecov'
require 'pry'

if RUBY_VERSION.to_i >= 2
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    Coveralls::SimpleCov::Formatter,
    SimpleCov::Formatter::HTMLFormatter
  ]
else
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter
  ]
end

SimpleCov.start do
  add_filter "/spec/"
end

# Previous content of test helper now starts here
require "sports_data_api"


# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'webmock/rspec'
require 'vcr'

def api_key(sport)
  key = 'VALID_SPORTS_DATA_API_KEY'
  key = ENV["SPORTS_DATA_#{sport.to_s.upcase}_API_KEY"] if ENV.has_key?("SPORTS_DATA_#{sport.to_s.upcase}_API_KEY")
  key
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.preserve_exact_body_bytes { true }
  c.configure_rspec_metadata!

  ##
  # Filter the real API key so that it does not make its way into the VCR cassette
  c.filter_sensitive_data('<API_KEY>')  { api_key(:nfl) }
  c.filter_sensitive_data('<API_KEY>')  { api_key(:ncaafb) }
  c.filter_sensitive_data('<API_KEY>')  { api_key(:nba) }
  c.filter_sensitive_data('<API_KEY>')  { api_key(:mlb) }
  c.filter_sensitive_data('<API_KEY>')  { api_key(:nhl) }
  c.filter_sensitive_data('<API_KEY>')  { api_key(:ncaamb) }
end
