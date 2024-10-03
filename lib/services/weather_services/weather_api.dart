import 'dart:convert';
import 'package:biovitality/services/weather_services/weather_data.dart';
import 'package:http/http.dart' as http;

class WeatherAPI {
  late WeatherData _weatherData;
  List<ForecastData> _forecastData = []; // Initialize an empty list

  Future<void> fetchWeatherData(double lat, double lon) async {
    final apiKey = '01fa6b38027263f5b0e0c6a11b984282'; // API key
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      _weatherData = WeatherData.fromJson(jsonData);
    } else {
      print('Failed to load weather data: ${response.statusCode}');
    }

    // Fetch 5-day forecast data
    final forecastUrl = Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
    final forecastResponse = await http.get(forecastUrl);

    if (forecastResponse.statusCode == 200) {
      final forecastJsonData = json.decode(forecastResponse.body);
      _forecastData = forecastJsonData['list'].map<ForecastData>((json) => ForecastData.fromJson(json)).toList();
    } else {
      print('Failed to load forecast data: ${forecastResponse.statusCode}');
    }
  }

  WeatherData get weatherData => _weatherData;
  List<ForecastData> get forecastData => _forecastData;
}

class ForecastData {
  final DateTime date;
  final double temperature;
  final String weatherDescription;

  ForecastData({required this.date, required this.temperature, required this.weatherDescription});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true).toLocal(),
      temperature: json['main']['temp'] is int? json['main']['temp'].toDouble() : json['main']['temp'],
      weatherDescription: json['weather'][0]['main'],
    );
  }
}