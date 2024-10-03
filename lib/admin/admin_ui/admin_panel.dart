import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'manage_users_screen.dart';
import 'manage_shops_screen.dart';

class AdminPanel extends StatefulWidget {
  final String adminUid; // Admin UID passed from previous screen

  AdminPanel({required this.adminUid});

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();

  int _totalUsers = 0;
  int _totalShops = 0;

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  void _fetchStats() {
    // Listen for real-time updates for users count
    _dbRef.child('biovitality_users').onValue.listen((event) {
      final DataSnapshot snapshot = event.snapshot;
      int userCount = 0;
      if (snapshot.value != null) {
        userCount = (snapshot.value as Map<dynamic, dynamic>).length;
      }
      setState(() {
        _totalUsers = userCount;
      });
    });

    // Listen for real-time updates for shops count
    _dbRef.child('Shops').onValue.listen((event) {
      final DataSnapshot snapshot = event.snapshot;
      int shopCount = 0;
      if (snapshot.value != null) {
        shopCount = (snapshot.value as Map<dynamic, dynamic>).length;
      }
      setState(() {
        _totalShops = shopCount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin UID: ${widget.adminUid}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Stats section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Users:',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _totalUsers.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Shops:',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _totalShops.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Manage Users',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to manage users screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageUsersScreen()),
                );
              },
              child: Text('Manage Users'),
            ),
            SizedBox(height: 20),
            Text(
              'Manage Shops',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to manage shops screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageShopsScreen()),
                );
              },
              child: Text('Manage Shops'),
            ),
          ],
        ),
      ),
    );
  }
}