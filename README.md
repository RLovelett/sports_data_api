# SportsDataApi 

[![Build Status](https://travis-ci.org/RLovelett/sports_data_api.svg?branch=master)](https://travis-ci.org/RLovelett/sports_data_api) [![Gem Version](https://badge.fury.io/rb/sports_data_api.svg)](http://badge.fury.io/rb/sports_data_api) [![Code Climate](https://codeclimate.com/github/RLovelett/sports_data_api/badges/gpa.svg)](https://codeclimate.com/github/RLovelett/sports_data_api) [![Test Coverage](https://codeclimate.com/github/RLovelett/sports_data_api/badges/coverage.svg)](https://codeclimate.com/github/RLovelett/sports_data_api/coverage)

SportsDataApi is an attempt to make a Ruby interface to the
[Sportradar](http://www.sportradar.com/) (previously known as SportsData) API. The goal is to
eventaully support the full API. Pull requests that extend the API
support are always welcome.

[Sportradar](http://www.sportradar.com/)’s comprehensive data coverage includes all major U.S. sports,
plus hundreds of leagues throughout the world. Their live game analysts
capture every possible event of every game, in real time and with
accuracy standards developed from years of experience.

## Author

[Ryan Lovelett](http://ryan.lovelett.me/) ( [@rlovelett](http://twitter.com/#!/rlovelett) )

Drop me a message for any questions, suggestions, requests, bugs or
submit them to the [issue
log](https://github.com/rlovelett/sports_data_api/issues).

## API Support

  * [NFL](http://developer.sportradar.com/files/indexFootball.html#classic-nfl-api)
  * [NBA](http://developer.sportradar.com/files/indexBasketball.html#nba-api)
  * [MLB](http://developer.sportradar.com/files/indexBaseball.html#major-league-baseball-api-v6)
  * [NHL](http://developer.sportradar.com/files/indexHockey.html#nhl-api)
  * [NCAAMB](http://developer.sportradar.com/files/indexBasketball.html#ncaa-men-39-s-basketball-api)
  * [NCAA Football](http://developer.sportradar.com/files/indexFootball.html#ncaa-football-api)
  * [Golf](http://developer.sportradar.com/files/indexGolf.html)

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

### Example if you want to get weekly stats for a player.

```ruby
SportsDataApi.set_access_level(:nfl, '<YOUR ACCESS LEVEL HERE>')
SportsDataApi.set_key(:nfl, '<YOUR API KEY HERE>')
game_stats = SportsDataApi::Nfl.game_statistics(2014, :REG, 9, 'HOU', 'PHI')
foster_stats = game_stats.home_team.players.select { |player| player['name'] === 'Arian Foster' }.first
puts foster_stats
=> {
  "id": "d89d2aef-c383-4ddf-bed8-3761aed35b10",
  "name": "Arian Foster",
  "jersey": 23,
  "position": "RB",
  "touchdowns": {
    "pass": 1,
    "rush": 0,
    "int": 0,
    "fum_ret": 0,
    "punt_ret": 0,
    "kick_ret": 0,
    "fg_ret": 0,
    "other": 0
  },
  "rushing": {
    "att": 15,
    "yds": 56,
    "avg": 3.733,
    "lg": 18,
    "td": 0,
    "fd": 3,
    "fd_pct": 20,
    "sfty": 0,
    "rz_att": 0,
    "fum": 0,
    "yds_10_pls": 2,
    "yds_20_pls": 0,
    "yds_30_pls": 0,
    "yds_40_pls": 0,
    "yds_50_pls": 0
  },
  "receiving": {
    "tar": 3,
    "rec": 2,
    "yds": 63,
    "yac": 63,
    "fd": 1,
    "avg": 31.5,
    "td": 1,
    "lg": 56,
    "rz_tar": 0,
    "fum": 0,
    "yds_10_pls": 0,
    "yds_20_pls": 0,
    "yds_30_pls": 0,
    "yds_40_pls": 0,
    "yds_50_pls": 1
  },
  "first_downs": {
    "num": 4,
    "pass": 1,
    "rush": 3,
    "pen": 0
  }
}
```

## Testing

The tests for the API have been mocked using [VCR](https://github.com/vcr/vcr) and [WebMock](https://github.com/bblimke/webmock).

Actual calls to the Sports Data LLC have been mocked out to prevent storage of valid API credentials and making
superflous API calls while testing. As such, in order to generically run the tests (without actually hitting)
the server the only thing that needs to be done is to run the specs (e.g., `bundle exec rake spec` or
`bundle exec guard start`).

However, if you want to refresh the actual server API responses you will need to re-record all of the VCR cassettes.
This can be achieved simply by performing the following two steps:

1. Delete all the cassettes (`rm spec/cassettes/*.yml`)
2. Run specs passing the API key as environment variable (`SPORTS_DATA_<NFL|NBA|MLB|NHL|NCAAMB|NCAAFB|GOLF>_API_KEY=realapikey bundle exec rake spec`)

## Contributing

1. Fork it
2. Create a topic branch (`git checkout -b topic`)
3. Make your changes
4. Squash your changes into one commit
5. Create new Pull Request against this squashed commit
