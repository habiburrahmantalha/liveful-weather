import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/screens/home/data/repository/repository_city.dart';
import 'package:weather/screens/home/data/repository/repository_weather.dart';
import 'package:weather/screens/home/domain/city_cubit.dart';
import 'package:weather/screens/home/domain/weather_bloc.dart';
import 'package:weather/screens/home/presentation/widget/city_search.dart';
import 'package:weather/screens/home/presentation/widget/current_weather.dart';
import 'package:weather/screens/home/presentation/widget/weather_forecast.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() {
    return _ScreenHomeState();
  }
}

class _ScreenHomeState extends State<ScreenHome> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String apiKey = dotenv.env['API_KEY_WEATHER'] ?? '';
    return MultiBlocProvider(
      // Providing multiple BLoCs (CityCubit and WeatherBloc) to the widget tree
    providers: [
        BlocProvider(create: (context) => CityCubit(repository: RepositoryCity())),
        BlocProvider(create: (context) => WeatherBloc(repository: RepositoryWeather(), appId: apiKey))
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Quick Weather App'),
        ),
        body: SingleChildScrollView(
          // Using SingleChildScrollView to enable scrolling if the content overflows
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Widget for city search functionality
              const CitySearch(),
              // Text header for weather forecast section
              const CurrentWeather(),
              // Widget to display weather forecast information
              WeatherForecast(),
            ],
          ),
        ),
      ),
    );
  }
}






