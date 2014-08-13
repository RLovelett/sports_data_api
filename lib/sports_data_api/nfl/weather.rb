module SportsDataApi
  module Nfl
    class Weather
      attr_reader :temperature, :condition, :humidity, :wind_speed, :wind_direction
      def initialize(weather_hash)
        if weather_hash
          @temperature = weather_hash['temperature']
          @condition = weather_hash['condition']
          @humidity = weather_hash['humidity']
          @wind_speed = weather_hash['wind']['speed']
          @wind_direction = weather_hash['wind']['direction']
        end
      end
    end
  end
end
