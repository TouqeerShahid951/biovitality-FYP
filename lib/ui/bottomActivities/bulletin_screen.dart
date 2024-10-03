import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BulletinScreen extends StatefulWidget {
  const BulletinScreen();

  @override
  State<BulletinScreen> createState() => _BulletinScreenState();
}

class _BulletinScreenState extends State<BulletinScreen> {
  int _selectedIndex = 3;
  List<dynamic> _news = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiKey = '3a3b7697b4619f37f041ae5594ec48e3';
    final url = Uri.parse(
        'https://gnews.io/api/v4/top-headlines?category=general&lang=ur&country=pk&max=10&apikey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _news = jsonData['articles'];
        _isLoading = false;
      });
    } else {
      print('Failed to load news: ${response.statusCode}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/market_view');
        break;
      case 2:
        Navigator.pushNamed(context, '/weather');
        break;
      case 3:
        break;
      default:
        break;
    }
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Latest News",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
        ),
        body: Container(
          color: Colors.green.shade50,
          child: _isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
            itemCount: _news.length,
            itemBuilder: (context, index) {
              final article = _news[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5.0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    onTap: () {
                      // Open the full article in a web view or another screen
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          child: article['image'] != null
                              ? Image.network(
                            article['image'],
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                          )
                              : Container(
                            height: 180,
                            color: Colors.grey.shade200,
                            child: Icon(Icons.image, size: 50),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article['title'] ?? '',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                article['description'] ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
}
