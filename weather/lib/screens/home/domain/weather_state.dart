part of 'weather_bloc.dart';

/// Enum defining the various loading states.
enum LoadingStatus {
  initial,
  loading,
  success,
  failed;

  bool get isLoading => this == LoadingStatus.loading;

  bool get isSuccess => this == LoadingStatus.success;
}

/// Class representing the state of the weather feature in the application.
class WeatherState extends Equatable {
  final ResponseWeather? weather;
  final List<WeatherData>? forecast;
  final LoadingStatus? statusWeather;
  final LoadingStatus? statusForecast;
  final String? errorText;
  final int? currentTime;

  const WeatherState({
    this.weather,
    this.forecast,
    this.statusWeather,
    this.statusForecast,
    this.errorText,
    this.currentTime
  });


  @override
  List<Object?> get props =>
      [weather, forecast, statusWeather, statusForecast, errorText, currentTime];

  WeatherState copyWith({
    ResponseWeather? weather,
    List<WeatherData>? forecast,
    LoadingStatus? statusWeather,
    LoadingStatus? statusForecast,
    String? errorText,
    int? currentTime,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      forecast: forecast ?? this.forecast,
      statusWeather: statusWeather ?? this.statusWeather,
      statusForecast: statusForecast ?? this.statusForecast,
      errorText: errorText ?? this.errorText,
      currentTime: currentTime ?? this.currentTime,
    );
  }
}


