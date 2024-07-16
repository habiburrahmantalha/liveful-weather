part of 'weather_bloc.dart';

/// Sealed class defining different weather-related events that can be handled by the WeatherBloc.
sealed class WeatherEvent extends Equatable {
  const WeatherEvent();
}
/// Event triggered to fetch current weather data for a specific city.
class FetchWeather extends WeatherEvent {
  final String cityName;

  const FetchWeather({required this.cityName});

  @override
  List<Object> get props => [cityName];
}
/// Event triggered to fetch weather forecast data for a specific city.
class FetchForecast extends WeatherEvent {
  final String cityName;

  const FetchForecast({required this.cityName});

  @override
  List<Object> get props => [cityName];
}
