import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';

class ManageShopsScreen extends StatefulWidget {
  @override
  _ManageShopsScreenState createState() => _ManageShopsScreenState();
}

class _ManageShopsScreenState extends State<ManageShopsScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  String _imageUrl = ''; // URL of the uploaded image
  File? _imageFile; // Image file to upload
  TextEditingController _nameController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();

  Future<void> _uploadImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _addShop() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      // Upload image to Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref().child('shop_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(_imageFile!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Add shop data to Firebase Realtime Database
      final newShopRef = _dbRef.child('Shops').push();
      await newShopRef.set({
        'name': _nameController.text.trim(),
        'image': downloadUrl,
        'latitude': double.parse(_latitudeController.text.trim()),
        'longitude': double.parse(_longitudeController.text.trim()),
      });

      // Clear input fields and image file
      _nameController.clear();
      _latitudeController.clear();
      _longitudeController.clear();
      setState(() {
        _imageUrl = '';
        _imageFile = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Shop added successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error adding shop: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add shop.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _deleteShop(String shopId) async {
    try {
      await _dbRef.child('Shops').child(shopId).remove();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Shop deleted successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error deleting shop: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete shop.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Shops'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Shop Name'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _latitudeController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Latitude'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _longitudeController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Longitude'),
            ),
            SizedBox(height: 10),
            _imageFile != null
                ? Image.file(
              _imageFile!,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            )
                : SizedBox.shrink(),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addShop,
              child: Text('Add Shop'),
            ),
            SizedBox(height: 20),
            Text(
              'Existing Shops',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            StreamBuilder(
              stream: _dbRef.child('Shops').onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  if (snapshot.data!.snapshot.value is Map<dynamic, dynamic>) {
                    Map<dynamic, dynamic> shops = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                    return Column(
                      children: shops.entries.map((entry) {
                        String shopId = entry.key;
                        if (entry.value is Map<dynamic, dynamic>) {
                          Map<dynamic, dynamic> shopData = entry.value as Map<dynamic, dynamic>;
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(shopData['image']),
                              ),
                              title: Text(shopData['name']),
                              subtitle: Text(
                                  'Lat: ${shopData['latitude']}, Long: ${shopData['longitude']}'),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteShop(shopId);
                                },
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: Text('No shops found.'),
                    );
                  }
                } else {
                  return Center(
                    child: Text('No shops found.'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}