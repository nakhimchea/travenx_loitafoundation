class ModelWeatherForecast {
  final List<String> forecast;
  final String sunrise;
  final String sunset;
  final int temperature;

  ModelWeatherForecast({
    required this.forecast,
    required this.sunrise,
    required this.sunset,
    required this.temperature,
  });
}
