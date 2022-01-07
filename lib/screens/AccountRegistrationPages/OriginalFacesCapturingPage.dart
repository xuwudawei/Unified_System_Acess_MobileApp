import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:usa_app/colors.dart';

class FacesCapturingPage extends StatefulWidget {
  const FacesCapturingPage({Key? key}) : super(key: key);

  @override
  _FacesCapturingPageState createState() => _FacesCapturingPageState();
}

class _FacesCapturingPageState extends State<FacesCapturingPage> {
  final ImagePicker _imagePicker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();
  File? _processedFile;
  bool _inProcess = false;
  final int _maxNumberOfImages = 10;
  final List<String> _paths = List.filled(10, '');
  // final List<String> cache = List.filled(5, '');
  int _lastInsertedIndex = 0;

  Future<void> _getImage() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        File? cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          // aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 3),
          compressQuality: 100,
          // maxWidth: 700,
          // maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          iosUiSettings: IOSUiSettings(),
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.blueAccent,
            toolbarTitle: "Crop your image",
            activeControlsWidgetColor: Colors.blueAccent,
            toolbarWidgetColor: Colors.white,
            statusBarColor: Colors.blueAccent,
            backgroundColor: Colors.white,
          ),
        );
        this.setState(() {
          _processedFile = cropped;
          if (_lastInsertedIndex < _maxNumberOfImages) {
            _paths[_lastInsertedIndex] = _processedFile!.path;
            _lastInsertedIndex++;
          }
        });
        print("Cropped image:$cropped");
      } else {
        this.setState(() {
          _inProcess = false;
        });
      }
    } catch (e) {
      print(e);
    }

    // setState(() {
    //   if (_lastInsertedIndex < _maxNumberOfImages) {
    //     _paths[_lastInsertedIndex] = image!.path;
    //     _lastInsertedIndex++;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face ID Registration'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          //Make sure you modify the code here to make changes to the video recording then remove alml routes to home page next
          GestureDetector(
            // onTap: () => Navigator.pushNamed(context, '/home'),
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Upload 10 images of  different angles of your face",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                    itemCount: 10,
                    itemBuilder: (BuildContext cntx, int index) => _paths !=
                                null &&
                            _paths[index].isNotEmpty
                        ? Image.file(File(_paths[index]), fit: BoxFit.fitWidth)
                        : Container(color: Colors.grey[300]),
                  ),
                ),
              ),
            ],
          ),
          (_inProcess)
              ? Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Center()
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            label: Text('Add Faces'),
            icon: Icon(Icons.camera),
            onPressed: () async {
              await _getImage();
            },
          ),
        ],
      ),
    );
  }
}
