class Endpoint{
  static String getCIty(String city) => "geo/cities?namePrefix=$city";
  static String getCurrentWeather(String appId, String query) => "weather?units=metric&q=$query&appid=$appId";
  static String getForecastWeather(String appId, String query) => "forecast?units=metric&q=$query&appid=$appId";
}