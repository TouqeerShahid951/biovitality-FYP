import 'package:biovitality/services/weather_services/weather_api.dart';
import 'package:biovitality/services/weather_services/weather_data.dart';
import 'package:biovitality/services/weather_services/weather_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen();

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherData _weatherData = WeatherData();
  final WeatherAPI _weatherAPI = WeatherAPI();
// Initialize an empty list

  int _selectedIndex = 2;

  Future<bool> _onWillPop() async {
    SystemNavigator.pop(); // Exit the app when the user clicks the back button
    return false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
      // Handle Crop Care tab
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
      // Handle Market View tab
        Navigator.pushNamed(context, '/market_view');
        break;
      case 2:
      // Handle Weather tab (no need to navigate)
        break;
      case 3:
      // Handle Bulletin tab
        Navigator.pushNamed(context, '/bulletin');
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isDataLoaded = false; // Set data loaded to false
    });
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final lat = position.latitude;
    final lon = position.longitude;
    await _weatherAPI.fetchWeatherData(lat, lon);
    setState(() {
      _weatherData.updateData(_weatherAPI.weatherData);
      _isDataLoaded = true; // Set data loaded to true
    });
  }

  // Add a RefreshIndicator widget to the body
  bool _isDataLoaded = false; // Add a boolean to track if data is loaded

  Future<void> _refresh() async {
    setState(() {
    });
    await _getCurrentLocation();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weather in ${_weatherData.cityName}', style: TextStyle(color: CupertinoColors.lightBackgroundGray, fontWeight: FontWeight.bold),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green.shade400,
        ),
        body: _isDataLoaded
            ? RefreshIndicator(
          onRefresh: _refresh,
          child: WeatherBody(_weatherData, _weatherAPI.forecastData), // Pass _weatherAPI.forecastData as the second argument
        )
            : Center(
          child: CircularProgressIndicator(), // Show a loading indicator while data is loading
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.grass),
              label: 'Crop Care',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Agri Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'News',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}