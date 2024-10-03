import 'package:biovitality/ui/user_login_screen.dart';
import 'package:biovitality/ui/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';



class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child("profile_image");
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? _user;
  String _email = '';
  String _name = '';
  String _profileImageUrl = '';
  String _contact = '';
  String _address = '';

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      setState(() {
        _email = _user!.email ?? '';
      });
      var dataSnapshot = await FirebaseDatabase.instance.reference().child("biovitality_users").child(_user!.uid).once();
      var userData = dataSnapshot.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _name = userData['name'] ?? '';
        _contact = userData['contact'] ?? '';
        _address = userData['address'] ?? '';
      });
      var profileImageSnapshot = await _dbRef.child(_user!.uid).once();
      var profileImageData = profileImageSnapshot.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _profileImageUrl = profileImageData['profileImageUrl'] ?? '';
      });
    }
  }

  Future<void> _selectImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final storageRef = _storage.ref().child('biovitality_users/${_user!.uid}.jpg');
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();
      setState(() {
        _profileImageUrl = url;
      });
      await _dbRef.child(_user!.uid).update({'profileImageUrl': url});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _profileImageUrl.isEmpty
                        ? AssetImage('assets/images/myprofile_icon.png') as ImageProvider
                        : _profileImageUrl.startsWith('http')
                        ? NetworkImage(_profileImageUrl)
                        : FileImage(File(_profileImageUrl)) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    child: GestureDetector(
                      onTap: _selectImage,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black54,
                        ),
                        child: Icon(Icons.camera_alt, size: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              itemProfile('Name', _name, CupertinoIcons.person, Icons.edit),
              const SizedBox(height: 10),
              itemProfile('Phone', _contact, CupertinoIcons.phone, Icons.phone),
              const SizedBox(height: 10),
              itemProfile('Address', _address, CupertinoIcons.location, Icons.location_on),
              const SizedBox(height: 10),
              itemProfile('Email', _email, CupertinoIcons.mail, Icons.email),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateProfile()),
                    );
                    if (result == true) {
                      _getUserData();  // Refresh the data if the profile was updated
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Update Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade800,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Log Out', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData, IconData trailingIcon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.green.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 10,
            )
          ]
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
        leading: Icon(iconData, color: Colors.green),
        trailing: Icon(trailingIcon, color: Colors.grey.shade400),
      ),
    );
  }
}