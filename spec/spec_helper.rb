require 'simplecov'
require 'pry'
require 'rspec/its'
require 'rspec/collection_matchers'

SimpleCov.start do
  add_filter '/spec/'
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
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

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

  # VCR will prevent the codeclimate-test-reporter from reporting results to
  # codeclimate.com. Configure VCR to ignore the codeclimate.com hostname to
  # ensure codeclimate-test-reporter can post coverage results.
  c.ignore_hosts 'codeclimate.com'

  ##
  # Filter the real API key so that it does not make its way into the VCR cassette
  c.filter_sensitive_data('<API_KEY>')  { api_key(:nfl) }
  c.filter_sensitive_data('<API_KEY>')  { api_key(:ncaafb) }
  c.filter_sensitive_data('<API_KEY>')  { api_key(:nba) }
  c.filter_sensitive_data('<API_KEY>')  { api_key(:mlb) }
  c.filter_sensitive_data('<API_KEY>')  { api_key(:nhl) }
  c.filter_sensitive_data('<API_KEY>')  { api_key(:ncaamb) }
end
