# CHANGELOG

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