part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final String cityName;

  const FetchWeather({required this.cityName});

  @override
  List<Object> get props => [cityName];
}

class FetchForecast extends WeatherEvent {
  final String cityName;

  const FetchForecast({required this.cityName});

  @override
  List<Object> get props => [cityName];
}
