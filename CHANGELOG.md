# CHANGELOG

## v0.15.3
* [#95](https://github.com/RLovelett/sports_data_api/pull/95) [FIX] Safe map of MLB json responses

## v0.15.2
* [#94](https://github.com/RLovelett/sports_data_api/pull/94) [FIX] Safe map of json responses

## v0.15.1
* [#92](https://github.com/RLovelett/sports_data_api/pull/92) [FIX] NFL extra points stats
* [#93](https://github.com/RLovelett/sports_data_api/pull/93) [Feature] Stats have #fetch like hash

## v0.15.0
* [#91](https://github.com/RLovelett/sports_data_api/pull/91) Adds V2 NFL Support
  
  Removes API for the following
    
    * SportsDataApi::Nfl.play\_by\_play
    * SportsDataApi::Nfl.weekly
    * SportsDataApi::Nfl.team\_season\_stats
    * SportsDataApi::Nfl.player\_season\_stats

    
* [#91](https://github.com/RLovelett/sports_data_api/pull/91) Removes support for Ruby 2.2

## v0.14.1

* [#90](https://github.com/RLovelett/sports_data_api/pull/90) [FIX] NHL Player was not parsing goaltending stats

## v0.14.0

* [#88](https://github.com/RLovelett/sports_data_api/pull/88) Change SportsDataApi::Exception => SportsDataApi::Error
