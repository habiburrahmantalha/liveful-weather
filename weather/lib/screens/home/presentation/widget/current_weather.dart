import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/screens/home/domain/weather_bloc.dart';
import 'package:weather/service/utils.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    // Using BlocBuilder to rebuild the widget when the WeatherState changes
    return BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state){
          switch(state.statusWeather){
          // Initial state and loading status
            case null:
            case LoadingStatus.initial:
              return const SizedBox.shrink();
            case LoadingStatus.loading:
              return const SizedBox(height: 160, child: Center(child: CircularProgressIndicator()));
            case LoadingStatus.success:
            // List to hold the weather information widgets
              List<Widget> list = [Text(
                '${state.weather?.main?.temp?.ceil() ?? -1}°C',
                style: const TextStyle(fontSize: 24),
              )];
              // Add weather icons to the list
              list.addAll(state.weather?.weather?.map((e)=> Image.network(
                'http://openweathermap.org/img/w/${e.icon}.png',
              )).toList() ?? []);
              // Return the weather information UI
              return Container(
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50]?.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the current date and time
                    Row(
                      children: [
                        Text(DateFormat("dd MMMM, yyyy hh:mm a").format(DateTime.now()),
                          style: const TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ],
                    ),
                    // Display city name and country
                    Text(
                      '${state.weather?.name ?? ""}, ${state.weather?.sys?.country ?? ""}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: list,
                    ),
                    // Display temperature and weather icons
                    Text(
                      'Feels like ${state.weather?.main?.feelsLike?.ceil() ?? -1}°C. ${state.weather?.weather?.map((e) => e.description)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'The high will be ${state.weather?.main?.tempMax?.ceil() ?? -1}°C, the low will be ${state.weather?.main?.tempMin?.floor() ?? -1}°C.',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12,),
                    // Display additional weather information in a wrap
                    Wrap(
                      spacing: 16,
                      children: [
                        if(state.weather?.rain?.h != null)
                          Text(
                            'Rain : ${state.weather?.rain?.h}mm',
                            style: const TextStyle(fontSize: 16),
                          ),
                        if(state.weather?.wind?.speed != null)
                          Text(
                            'Wind : ${state.weather?.wind?.speed}m/s',
                            style: const TextStyle(fontSize: 16),
                          ),
                        if(state.weather?.main?.pressure != null)
                          Text(
                            'Pressure : ${state.weather?.main?.pressure}hPa',
                            style: const TextStyle(fontSize: 16),
                          ),
                        if(state.weather?.main?.humidity != null)
                          Text(
                            'Humidity : ${state.weather?.main?.humidity}%',
                            style: const TextStyle(fontSize: 16),
                          ),
                        if(state.weather?.visibility != null)
                          Text(
                            'Visibility : ${state.weather?.visibility}m',
                            style: const TextStyle(fontSize: 16),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            case LoadingStatus.failed:
              return Text(state.errorText?.capitalize() ?? "Something went wrong.",
                  style: const TextStyle(fontSize: 16, color: Colors.redAccent));
          }
        });
  }
}