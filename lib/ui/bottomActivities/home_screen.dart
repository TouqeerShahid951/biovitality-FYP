import 'dart:async';
import 'dart:io';
import 'package:biovitality/ui/about_biovitality.dart';
import 'package:biovitality/ui/user_login_screen.dart';
import 'package:biovitality/ui/myprofile_screen.dart';
import 'package:biovitality/ui/terms_conditions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../model_detection_screen.dart';


extension<T> on List<T>? {
  Iterable<List<T>> chunk(int size) sync* {
    if (this != null) {
      for (int i = 0; i < this!.length; i += size) {
        yield this!.sublist(i, (i + size) > this!.length ? this!.length : i + size);
      }
    } else {
      yield <T>[];
    }
  }
}


class Home extends StatefulWidget {
  final String? uid;
  Home({this.uid});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // For tracking the selected index of the bottom navigation bar.

  DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child("biovitality_users");
  late Future<DataSnapshot> _userDataFuture;



  File? _image;
  String diseaseName = "";
  bool _busy = false;


  final List<Map<String, String>> crops = [
    {'name': 'Apple', 'asset': 'assets/crops/apple (1).png'},
    {'name': 'Banana', 'asset': 'assets/crops/banana.png'},
    {'name': 'Chilli', 'asset': 'assets/crops/chilli.png'},
    {'name': 'Citrus', 'asset': 'assets/crops/orange.png'},
    {'name': 'Maize', 'asset': 'assets/crops/corn (2).png'},
    {'name': 'Cotton', 'asset': 'assets/crops/cotton (1).png'},
    {'name': 'Grapes', 'asset': 'assets/crops/grape (2).png'},
    {'name': 'Mango', 'asset': 'assets/crops/mango (2).png'},
    {'name': 'Papaya', 'asset': 'assets/crops/papaya.png'},
    {'name': 'Potato', 'asset': 'assets/crops/potato (2).png'},
    {'name': 'Rice', 'asset': 'assets/crops/rice (2).png'},
    {'name': 'Tea', 'asset': 'assets/crops/green-tea (1).png'},
    {'name': 'Tomato', 'asset': 'assets/crops/tomato (3).png'},
    {'name': 'Rose', 'asset': 'assets/crops/red-rose.png'},
  ];

  @override
  void initState() {
    super.initState();
    print(widget.uid);
    _userDataFuture = _getUserData(widget.uid!);
    _busy = true;
    print(_userDataFuture);
  }

  Future<DataSnapshot> _getUserData(String uid) async {
    var event = await _dbRef.child(uid).once();
    return event.snapshot;
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index != 0) {
      switch (index) {
        case 1:
          Navigator.pushNamed(context, '/market_view');
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
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop(); // Exit the app when the user clicks the back button
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];

    if (_busy) {
      stackChildren.add(const Opacity(
        child: ModalBarrier(dismissible: false, color: Colors.grey),
        opacity: 0.3,
      ));
      stackChildren.add(const Center(child: CircularProgressIndicator()));
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crop Care', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                });
              },
            )
          ],
          backgroundColor: Colors.green.shade300,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Available Crops To Detect', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: 16,),
                ...crops.chunk(2).map((pair) => Row(
                  children: [
                    CropCard(cropName: pair[0]['name']!, assetPath: pair[0]['asset']!),
                    SizedBox(width: 4), // Adjust spacing between cards
                    CropCard(cropName: pair[1]['name']!, assetPath: pair[1]['asset']!),
                  ],
                )),
              ],
            ),
          ),
        ),
        // Stack(
        //   children: stackChildren,
        // ),
          drawer: FutureBuilder<DataSnapshot>(
            future: _userDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Display a loading indicator while fetching data
              } else {
                if (snapshot.hasData && snapshot.data != null) {
                  var userData = snapshot.data!.value as Map<dynamic, dynamic>;
                  String email = userData['email'] ?? 'No email found';
                  String name = userData['name'] ?? 'No name found';

                  return Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountEmail: Text(email),
                          accountName: Text(
                            name,
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.home),
                          title: Text('Home'),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to the Home page or perform other actions
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('My Profile'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyProfilePage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.info_outline),
                          title: Text('About BioVitality'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AboutBioVitality()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.description), // Icon for Terms and Conditions
                          title: Text('Terms and Conditions'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TermsConditions()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.exit_to_app), // Use Icons.exit_to_app instead
                          title: Text('Log Out'),
                          onTap: () {
                            Navigator.pop(context);
                            FirebaseAuth.instance.signOut().then((_) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  );

                } else {
                  // If no user data is available, show a default drawer
                  return Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountEmail: Text('No email found'),
                          accountName: Text('No name found'),
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.home),
                          title: Text('Home'),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to the Home page or perform other actions
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('My Profile'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyProfilePage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.info_outline),
                          title: Text('About BioVitality'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AboutBioVitality()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.description),
                          title: Text('Terms and Conditions'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TermsConditions()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.exit_to_app), // Use Icons.exit_to_app instead
                          title: Text('Log Out'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              }
            },
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



  void _navigateToNextPage(BuildContext context, String crop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetectionPage(crop: crop),
      ),
    );
  }
}

class CropCard extends StatelessWidget {
  final String cropName;
  final String assetPath;

  CropCard({required this.cropName, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _navigateToNextPage(context, cropName);
        },
        child: Card(
          elevation: 3.0,
          shadowColor: Colors.greenAccent,
          surfaceTintColor: Colors.greenAccent,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Column(
              children: [
                Image.asset(assetPath, width: 40, height: 40,),
                SizedBox(height: 8,),
                Text(cropName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context, String crop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetectionPage(crop: crop),
      ),
    );
  }
}