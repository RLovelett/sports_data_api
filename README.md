# SportsDataApi [![Build Status](https://travis-ci.org/toplinegamelabs/sports_data_api.png)](https://travis-ci.org/toplinegamelabs/sports_data_api) [![Coverage Status](https://coveralls.io/repos/RLovelett/sports_data_api/badge.png?branch=master)](https://coveralls.io/r/RLovelett/sports_data_api?branch=master)

SportsDataApi is an attempt to make a Ruby interface to the
[SportsData](http://www.sportsdatallc.com/) API. The goal is to
eventaully support the full API. Pull requests that extend the API
support are always welcome.

[SportsData](http://www.sportsdatallc.com/)’s comprehensive data coverage includes all major U.S. sports,
plus hundreds of leagues throughout the world. Their live game analysts
capture every possible event of every game, in real time and with
accuracy standards developed from years of experience.

## Author

[Ryan Lovelett](http://ryan.lovelett.me/) ( [@rlovelett](http://twitter.com/#!/rlovelett) )

Drop me a message for any questions, suggestions, requests, bugs or
submit them to the [issue
log](https://github.com/rlovelett/sports_data_api/issues).

## API Support

  * [NFL](http://developer.sportsdatallc.com/docs/NFL_API)
  * [NBA](http://developer.sportsdatallc.com/docs/NBA_API)
  * TODO
    1. [MLB](http://developer.sportsdatallc.com/docs/MLB_API)
    2. [NHL](http://developer.sportsdatallc.com/docs/NHL_API)
    3. [NCAA Basketball](http://developer.sportsdatallc.com/docs/NCAA_Mens_Basketball)
    4. [NCAA Football](http://developer.sportsdatallc.com/docs/NCAA_Football_API)

## Installation

Add this line to your application's Gemfile:

    gem 'sports_data_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sports_data_api

## Usage

The specs for this Gem should give you some idea of how to make use of
the API. For now they will be the usage information. As always Pull
Requests for better documentation are welcome.

## Testing

The tests for the API have been mocked using [VCR](https://github.com/vcr/vcr) and [WebMock](https://github.com/bblimke/webmock).

Actual calls to the Sports Data LLC have been mocked out to prevent storage of valid API credentials and making
superflous API calls while testing. As such, in order to generically run the tests (without actually hitting)
the server the only thing that needs to be done is to run the specs (e.g., `bundle exec rake spec` or
`bundle exec guard start`).

However, if you want to refresh the actual server API responses you will need to re-record all of the VCR cassettes.
This can be achieved simply by performing the following two steps:

1. Delete all the cassettes (`rm spec/cassettes/*.yml`)
2. Run specs passing the API key as environment variable (`SPORTS_DATA_<NBA|NFL>_API_KEY=realapikey bundle exec rake spec`)

## Contributing

1. Fork it
2. Create a topic branch (`git checkout -b topic`)
3. Make your changes
4. Squash your changes into one commit
5. Create new Pull Request against this squashed commit
