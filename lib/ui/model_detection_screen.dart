import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:biovitality/ui/cure_screen.dart';
import 'package:biovitality/services/model_detection_service.dart';

class DetectionPage extends StatefulWidget {
  final String crop;

  const DetectionPage({required this.crop});

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  File? _image;
  late DetectionService _detectionService;

  @override
  void initState() {
    super.initState();
    _detectionService = DetectionService(crop: widget.crop);
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Make a choice! "),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Gallery "),
                  onTap: () {
                    _predictImagePickerGallery(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text("Camera "),
                  onTap: () {
                    _predictImagePickerCamera(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _predictImagePickerGallery(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });
    Navigator.of(context).pop();
    try {
      var result = await _detectionService.predictImagePickerGallery(_image!);
      _showResultDialog(result);
    } catch (e) {
      print("Error predicting image: $e");
      // Handle error, e.g., show a toast or dialog indicating the error
    }
  }

  Future<void> _predictImagePickerCamera(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });
    Navigator.of(context).pop();
    try {
      var result = await _detectionService.predictImagePickerGallery(_image!);
      _showResultDialog(result);
    } catch (e) {
      print("Error predicting image: $e");
      // Handle error, e.g., show a toast or dialog indicating the error
    }
  }

  Future<void> _showResultDialog(String result) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Result"),
          content: Text(
            result,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _handleCure(result);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Cure"),
            ),
          ],
        );
      },
    );
  }

  void _handleCure(String result, {Image? img}) {
    img ??= Image.file(_image!);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Cure(result, img),
    ));
  }

  @override
  void dispose() {
    _detectionService.closeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: _image == null
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_image.png',
            height: 100,
            width: 100,
          ),
          SizedBox(height: 10),
          Text('No image selected.'),
        ],
      )
          : Image.file(_image!),
    ));

    // if (_detectionService.busy) {
    //   stackChildren.add(const Opacity(
    //     child: ModalBarrier(dismissible: false, color: Colors.grey),
    //     opacity: 0.3,
    //   ));
    //   stackChildren.add(const Center(child: CircularProgressIndicator()));
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detection for: ${widget.crop}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: stackChildren,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.camera),
      ),
    );
  }
}