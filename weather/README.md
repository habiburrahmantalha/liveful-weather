# Weather App

## Introduction
The Weather App fetches and displays weather data from OpenWeatherMap based on user input (city name). 
This app is built using Flutter and demonstrates API integration, basic UI design, and error handling.

## Features
- Search bar to input city name
- Fetch and display current weather information:
    - City name
    - Temperature
    - Weather condition
    - Weather icon
    - Weather forecast for next 5 days
- Error handling for network issues and invalid city names

## Project Structure
- lib/screens: Contains the main UI and app logic.
- lib/service: Contains the API calling singleton, utils, etc.
## Approach
- Setup and Basic UI: Created the project and added a basic UI with a search bar and button.
- API Integration: Integrated OpenWeatherMap API to fetch weather data.
- Display Data: Displayed fetched data on the UI.
- Error Handling: Added error handling for network issues and invalid inputs.

## Setup and Run
1. Clone the repository:
   ```bash
   git clone https://github.com/habiburrahmantalha/liveful-weather.git
   cd weather
   flutter pub get
   flutter run



