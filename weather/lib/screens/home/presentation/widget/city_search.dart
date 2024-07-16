import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/screens/home/data/model/response_city_list.dart';
import 'package:weather/screens/home/domain/city_cubit.dart';
import 'package:weather/screens/home/domain/city_state.dart';
import 'package:weather/screens/home/domain/weather_bloc.dart';
import 'package:weather/service/utils.dart';

class CitySearch extends StatefulWidget {
  const CitySearch({super.key});

  @override
  State<CitySearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityCubit, CityState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Autocomplete<CityData>(
            // This function returns the list of city suggestions based on user input
            optionsBuilder: (TextEditingValue textEditingValue) {
              // Return an empty list if the input is less than 3 characters
              if (textEditingValue.text.isEmpty) {
                return const Iterable<CityData>.empty();
              }
              // Return the list of cities if the state is CityLoaded
              if (state is CityLoaded) {
                return state.cities.where((CityData city) {
                  return (city.name ?? "").toLowerCase().contains(textEditingValue.text.toLowerCase());
                });
              } else if (state is CityError) {
                // Return an empty list if there is an error
                return const Iterable<CityData>.empty();
              }
              // Default return value is an empty list
              return const Iterable<CityData>.empty();
            },
            // This function determines how each suggestion will be displayed
            displayStringForOption: (CityData option) => option.name ?? "",
            // This function is called when a user selects a suggestion
            onSelected: (CityData selection) {
              printDebug(selection.name);
              FocusManager.instance.primaryFocus?.unfocus();
              getWeather(selection.name ?? "");
            },
            // This function builds the text field for user input
            fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: 'Enter city name',
                  border: const OutlineInputBorder(),
                  suffixIcon: SizedBox(
                    width: 96,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if(controller.text.isNotEmpty)
                        // Clear button to clear the text field
                          IconButton(
                            onPressed: (){
                              printDebug(controller.text);
                              controller.clear();
                              setState(() {});
                            },
                            icon: const Icon(Icons.clear),
                            padding: EdgeInsets.zero,
                          ),
                        // Search button to trigger weather fetch
                        IconButton(
                          onPressed: (){
                            printDebug(controller.text);
                            focusNode.unfocus();
                            getWeather(controller.text);
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                ),
                onEditingComplete: onEditingComplete,
                textInputAction: TextInputAction.done,
                // This function is called when the user submits the text
                onSubmitted: (String? value){
                  printDebug(value);
                  focusNode.unfocus();
                  getWeather(value ?? "");
                },
                onChanged: (value){
                  // Fetch city suggestions using CityCubit
                  if(value.length > 3) {
                    context.read<CityCubit>().onSearchTextUpdated(value);
                  }
                },
              );
            },
            // This function builds the list of suggestions
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final CityData option = options.elementAt(index);
                        return ListTile(
                          title: Text(option.name ?? "", style: const TextStyle(color: Colors.black),),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Function to fetch weather and forecast data for the selected city
  getWeather(String city){
    if(city.isEmpty){
      return;
    }
    context.read<WeatherBloc>().add(FetchForecast(cityName: city));
    context.read<WeatherBloc>().add(FetchWeather(cityName: city));
  }
}