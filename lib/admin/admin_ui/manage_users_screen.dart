import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();
  List<User> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final DatabaseEvent event = await _dbRef.child('biovitality_users').once();
    final DataSnapshot snapshot = event.snapshot;
    List<User> users = [];
    if (snapshot.value != null) {
      (snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
        users.add(User(
          uid: key,
          name: value['name'],
          email: value['email'],
        ));
      });
    }
    setState(() {
      _users = users;
      _isLoading = false;
    });
  }

  Future<void> _deleteUser(String uid) async {
    await _dbRef.child('biovitality_users').child(uid).remove();
    _fetchUsers(); // Refresh the user list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _users.isEmpty
          ? Center(child: Text('No users found.', style: TextStyle(fontSize: 24)))
          : ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_users[index].name),
            subtitle: Text(_users[index].email),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteUser(_users[index].uid);
              },
            ),
          );
        },
      ),
    );
  }
}

class User {
  String uid;
  String name;
  String email;

  User({required this.uid, required this.name, required this.email});
}