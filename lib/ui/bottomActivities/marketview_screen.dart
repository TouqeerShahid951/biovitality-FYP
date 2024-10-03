import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketViewScreen extends StatefulWidget {
  const MarketViewScreen();

  @override
  State<MarketViewScreen> createState() => _MarketViewScreenState();
}

class _MarketViewScreenState extends State<MarketViewScreen> {
  int _selectedIndex = 1;
  final databaseReference = FirebaseDatabase.instance.ref('Shops');

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
      // Already on Market View tab
        break;
      case 2:
        Navigator.pushNamed(context, '/weather');
        break;
      case 3:
        Navigator.pushNamed(context, '/bulletin');
        break;
      default:
        break;
    }
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop(); // Exit the app when the user clicks the back button
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Agri Shops",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
        ),
        body: Container(
          color: Colors.green.shade50, // Light green background
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> list = map.values.toList();
                      return ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          var item = list[index];
                          return Card(
                            color: Colors.greenAccent.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            child: Container(
                              margin: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/loading.gif',
                                      image: item['image'], // Actual image URL
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Shop Name:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          item['name'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            foregroundColor: Colors.white,
                                            minimumSize: Size(60, 34),
                                            maximumSize: Size(140, 34),
                                          ),
                                          onPressed: () {
                                            _openInGoogleMaps(
                                                item['latitude'], item['longitude']);
                                          },
                                          child: Text('View Location'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
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

  void _openInGoogleMaps(double latitude, double longitude) async {
    final String latString = latitude.toString();
    final String longString = longitude.toString();
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latString,$longString';
    final Uri googleMapsUri = Uri.parse(googleMapsUrl);
    if (await canLaunch(googleMapsUri.toString())) {
      await launch(googleMapsUri.toString());
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
