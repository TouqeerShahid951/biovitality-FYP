class WeatherData {
  String cityName;
  double temperature;
  String weatherDescription;
  int humidity;
  double windSpeed;
  int pressure;
  int visibility;
  DateTime? sunrise; // make sunrise nullable
  DateTime? sunset; // make sunset nullable
  DateTime? date;

  WeatherData({
    this.cityName = '',
    this.temperature = 0.0,
    this.weatherDescription = '',
    this.humidity = 0,
    this.windSpeed = 0.0,
    this.pressure = 0,
    this.visibility = 0,
    this.sunrise, // no default value needed
    this.sunset, // no default value needed
    this.date,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
        cityName: json['name'],
        temperature: json['main']['temp'] is int? json['main']['temp'].toDouble() : json['main']['temp'],
        weatherDescription: json['weather'][0]['main'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed'] is int? json['wind']['speed'].toDouble() : json['wind']['speed'],
        pressure: json['main']['pressure'],
        visibility: json['visibility'],
        sunrise: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000, isUtc: true).toLocal(),
        sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000, isUtc: true).toLocal(),
        date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true).toLocal()
    );
  }

  void updateData(WeatherData data) {
    cityName = data.cityName;
    temperature = data.temperature;
    weatherDescription = data.weatherDescription;
    humidity = data.humidity;
    windSpeed = data.windSpeed;
    pressure = data.pressure;
    visibility = data.visibility;
    sunrise = data.sunrise;
    sunset = data.sunset;
    date = data.date;
  }
}