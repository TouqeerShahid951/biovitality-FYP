import 'package:biovitality/services/weather_services/weather_api.dart';
import 'package:biovitality/services/weather_services/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherBody extends StatelessWidget {
  final WeatherData _weatherData;
  final List<ForecastData> _forecastData;

  const WeatherBody(this._weatherData, this._forecastData);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display weather image based on weather description
                _weatherData.weatherDescription.isNotEmpty
                    ? Image(
                  image: getWeatherImage(_weatherData.weatherDescription),
                  width: 250,
                  height: 200,
                )
                    : SizedBox(),
                // If weather data is not yet fetched, show an empty SizedBox
                SizedBox(height: 20),
                // Display temperature information
                Text(
                  'Weather: ${_weatherData.weatherDescription}',
                  style:
                  TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Temperature: ${_weatherData.temperature.toStringAsFixed(1)}°C',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(height: 20),
                // Display weather details in small boxes with icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherDetailBox(
                      icon: Icons.thermostat,
                      label: 'Humidity',
                      value: '${_weatherData.humidity}%',
                    ),
                    WeatherDetailBox(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: '${_weatherData.windSpeed.toStringAsFixed(1)} m/s',
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherDetailBox(
                      icon: Icons.bar_chart,
                      label: 'Pressure',
                      value: '${_weatherData.pressure} hPa',
                    ),
                    WeatherDetailBox(
                      icon: Icons.visibility,
                      label: 'Visibility',
                      value: '${_weatherData.visibility} m',
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherDetailBox(
                      icon: Icons.wb_sunny,
                      label: 'Sunrise',
                      value: '${_weatherData.sunrise?.hour}:${_weatherData.sunrise?.minute} AM',
                    ),
                    WeatherDetailBox(
                      icon: Icons.wb_sunny,
                      label: 'Sunset',
                      value: '${_weatherData.sunset?.hour}:${_weatherData.sunset?.minute} PM',
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Display forecast data
                Text(
                  'Forecast:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _forecastData.take(5).map((forecast) => ForecastBox(
                      forecastData: forecast,
                      date: forecast.date, // Pass the date here
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AssetImage getWeatherImage(String description) {
  switch (description) {
    case 'Clear':
      return AssetImage('assets/images/sunny.png');
    case 'Clouds':
      return AssetImage('assets/images/cloud.png');
    case 'Rain':
      return AssetImage('assets/images/rain.jpg');
    case 'Haze':
      return AssetImage('assets/images/haze.png');
    case 'Mist':
      return AssetImage('assets/images/mist.png');
    default:
      return AssetImage('assets/images/sunny.png');
  }
}

class ForecastBox extends StatelessWidget {
  final ForecastData _forecastData;
  final DateTime _date; // Receive the date here

  const ForecastBox({required ForecastData forecastData, required DateTime date})
      : _forecastData = forecastData,
        _date = date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Column(
        children: [
          // Display weather image based on weather description
          _forecastData.weatherDescription.isNotEmpty
              ? Image(
            image: getWeatherImage(_forecastData.weatherDescription),
            width: 40,
            height: 40,
          )
              : SizedBox(),
          SizedBox(height: 10),
          Text(
            '${DateFormat('dd/MM/yy').format(_date)}', // Use the received date here
            style: TextStyle(fontSize: 15),
          ),
          Text(
            '${_forecastData.temperature.toStringAsFixed(1)}°C',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            _forecastData.weatherDescription,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class WeatherDetailBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherDetailBox({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(
            label,
            style: TextStyle(fontSize: 15),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}