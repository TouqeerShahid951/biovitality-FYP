import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';


class DetectionService {
  late List _recognitions = [];
  late String _modelPath;
  late String _labelsPath;
  bool _busy = false; // Make _busy accessible

  bool get busy => _busy; // Getter for _busy

  DetectionService({required String crop}) {
    _busy = true;

    switch (crop) {
      case 'Apple':
        _modelPath = "assets/model_apple.tflite";
        _labelsPath = "assets/apple_labels.txt";
        break;
      case 'Banana':
        _modelPath = "assets/model_banana.tflite";
        _labelsPath = "assets/banana_labels.txt";
        break;
      case 'Chilli':
        _modelPath = "assets/model_chili.tflite";
        _labelsPath = "assets/chili_labels.txt";
        break;
      case 'Citrus':
        _modelPath = "assets/model_citrus.tflite";
        _labelsPath = "assets/citrus_labels.txt";
        break;
      case 'Maize':
        _modelPath = "assets/model_corn.tflite";
        _labelsPath = "assets/corn_labels.txt";
        break;
      case 'Cotton':
        _modelPath = "assets/model_cotton.tflite";
        _labelsPath = "assets/cotton_labels.txt";
        break;
      case 'Grapes':
        _modelPath = "assets/model_grape.tflite";
        _labelsPath = "assets/grape_labels.txt";
        break;
      case 'Mango':
        _modelPath = "assets/model_mango.tflite";
        _labelsPath = "assets/mango_labels.txt";
        break;
      case 'Papaya':
        _modelPath = "assets/model_papaya.tflite";
        _labelsPath = "assets/papaya_labels.txt";
        break;
      case 'Potato':
        _modelPath = "assets/model_potato.tflite";
        _labelsPath = "assets/potato_labels.txt";
        break;
      case 'Rice':
        _modelPath = "assets/model_rice.tflite";
        _labelsPath = "assets/rice_labels.txt";
        break;
      case 'Tea':
        _modelPath = "assets/model_tea.tflite";
        _labelsPath = "assets/tea_labels.txt";
        break;
      case 'Tomato':
        _modelPath = "assets/model_tomato.tflite";
        _labelsPath = "assets/tomato_labels.txt";
        break;
      case 'Rose':
        _modelPath = "assets/model_rose.tflite";
        _labelsPath = "assets/rose_labels.txt";
        break;
      default:
        throw Exception('Invalid crop name: $crop');
    }

    loadModel().then((val) {
      _busy = false;
    }).catchError((error) {
      // Handle model loading error
      _busy = false;
      print('Error loading model: $error');
    });
  }

  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: _modelPath,
        labels: _labelsPath,
      );
    } on PlatformException {
      print('Failed to load model.');
      throw ('Failed to load model');
    }
  }

  Future<String> predictImagePickerGallery(File image) async {
    if (image.path.isNotEmpty) {
      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 1, // Limit to one result
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      if (recognitions != null && recognitions.isNotEmpty) {
        _recognitions = recognitions;
        return recognitions[0]["label"];
      } else {
        // Handle the case where recognitions is null or empty, e.g., show an error message.
        print("Error: Recognitions is null or empty");
        throw Exception("Recognitions is null or empty");
      }
    } else {
      print("Error: File path is empty");
      throw Exception("File path is empty");
    }
  }

  void closeModel() {
    Tflite.close();
  }
}