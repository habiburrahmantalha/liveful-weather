import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/screens/home/data/model/response_forecast.dart';
import 'package:weather/screens/home/domain/weather_bloc.dart';
import 'package:weather/screens/home/presentation/widget/raw_button.dart';
import 'package:weather/service/utils.dart';

class WeatherForecast extends StatelessWidget {
  WeatherForecast({super.key});

  // ValueNotifier to track the selected index
  final ValueNotifier<int> valueNotifierSelectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifierSelectedIndex,
      builder: (context, selectedIndex, child){
        return BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state){
              switch(state.statusForecast){
                case null:
                case LoadingStatus.initial:
                case LoadingStatus.loading:
                case LoadingStatus.failed:
                  // Return an empty widget for initial , loading, failed state
                  return const SizedBox.shrink();
                case LoadingStatus.success:
                  List<WeatherData> list = state.forecast ?? [];
                  List<List<WeatherData>> finalList = [];
                  // Group forecast data by day
                  for(int i=0;i < 5;i++){
                    String data = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: i)));
                    printDebug(data);
                    List<WeatherData> byDay = list.where((e)=> e.dtTxt?.contains(data) == true).toList();
                    printDebug(byDay.length);
                    finalList.add(byDay);
                  }
                  return Column(
                    children: [
                      const Text('Weather forecast: ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                      const SizedBox(height: 16),
                      // Display the days of the week
                      SizedBox(
                        height: 72,
                        child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            scrollDirection: Axis.horizontal,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              return RawButton(
                                child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: valueNotifierSelectedIndex.value == index ? Colors.blue[200] : Colors.blue[50]?.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat("dd, EE").format(DateTime.now().add(Duration(days: index))),
                                          style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.w500),),
                                      ],
                                    )
                                ),
                                onTap: (){
                                  // Update selected index on tap
                                  valueNotifierSelectedIndex.value = index;
                                },
                              );
                            },
                            separatorBuilder: (context, index){
                              return const SizedBox(width: 12,);
                            },
                            itemCount: finalList.length
                        ),
                      ),
                      const SizedBox(height: 16,),
                      // Display the weather forecast for the selected day
                      SizedBox(
                        height: 160,
                        child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              return WeatherCardView(data: finalList[selectedIndex][index]);
                            },
                            separatorBuilder: (context, index){
                              return const SizedBox(width: 12,);
                            },
                            itemCount: finalList[selectedIndex].length
                        ),
                      ),
                      const SizedBox(height: 32,),
                    ],
                  );
              }
            });
      },
    );
  }
}

class WeatherCardView extends StatelessWidget {
  const WeatherCardView({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    DateTime? dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").tryParse(data.dtTxt ?? "" );
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50]?.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the time of the forecast
          Text( dateTime!= null ? DateFormat("h a").format(dateTime) : "",
            style: const TextStyle(fontSize: 14, color: Colors.blue),
          ),
          // Display the temperature
          Text(
            '${data.main?.temp?.ceil() ?? -1}°C',
            style: const TextStyle(fontSize: 20),
          ),
          // Display the min and max temperatures
          Text(
            "${data.main?.tempMin?.floor()}°C -${data.main?.tempMax?.ceil()}°C",
            style: const TextStyle(fontSize: 14 , fontWeight: FontWeight.w400),),
          // Display the weather icon
          Image.network(
            width: 40, height: 40,
            'http://openweathermap.org/img/w/${data.weather?.first.icon}.png',
          ),
          // Display the humidity if available
          if(data.main?.humidity != null)
            Text(
              '${data.main?.humidity}%',
              style: const TextStyle(fontSize: 16),
            ),
        ],
      ),
    );
  }
}
