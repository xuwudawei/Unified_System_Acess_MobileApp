import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

enum GovernmentIssueID { Passport, National_ID, Birth_Certificate }

class DocumentScanningPage extends StatefulWidget {
  const DocumentScanningPage({Key? key}) : super(key: key);

  @override
  _DocumentScanningPageState createState() => _DocumentScanningPageState();
}

class _DocumentScanningPageState extends State<DocumentScanningPage> {
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();
  File? _selectedFile;
  bool _inProcess = false;
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  GovernmentIssueID _selectedIDType = GovernmentIssueID.Passport;

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile!,
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.width / 1.5,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/images/documentSample.png",
        width: MediaQuery.of(context).size.width / 0.99,
        height: MediaQuery.of(context).size.height / 2.8,
        fit: BoxFit.cover,
      );
    }
  }

  getImage(ImageSource source) async {
    // this.setState(() {
    //   _inProcess = true;
    //   Future.delayed(
    //     Duration(seconds: 2),
    //     () => Navigator.pushNamedAndRemoveUntil(
    //         context, '/Country/DocumentScanning', (route) => false),
    //   );
    // });

    try {
      XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        File? cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 3),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "RPS Cropper",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ),
        );

        this.setState(() {
          _selectedFile = cropped;
        });
        print("Cropped image:$cropped");

        // this.setState(() {
        //   _selectedFile = cropped!;
        //   _inProcess = false;
        //   print("File Path: ${_selectedFile?.path}");
        //   print("File successfully cropped");
        // });
      } else {
        this.setState(() {
          _inProcess = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Color getColor(Set<MaterialState> states) {
    return Colors.blueAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          GestureDetector(
            child: Icon(Icons.arrow_forward_ios),
            onTap: () {
              if (_selectedFile != null) {
                Navigator.pushNamed(
                    context, '/Country/DocumentScanning/PersonalInfo');
              } else {
                _scaffold.currentState!.showSnackBar(
                  SnackBar(
                    content: Text(
                      "Please capture your government issued ID!",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Upload Government Issued ID",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Passport',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                  leading: Radio(
                    activeColor: Colors.blueAccent,
                    value: GovernmentIssueID.Passport,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    groupValue: _selectedIDType,
                    onChanged: (GovernmentIssueID? value) {
                      setState(() {
                        _selectedIDType = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text(
                    'National ID',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                  leading: Radio(
                    activeColor: Colors.blueAccent,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: GovernmentIssueID.National_ID,
                    groupValue: _selectedIDType,
                    onChanged: (GovernmentIssueID? value) {
                      setState(() {
                        _selectedIDType = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Birth Certificate',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                  leading: Radio(
                    activeColor: Colors.blueAccent,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: GovernmentIssueID.Birth_Certificate,
                    groupValue: _selectedIDType,
                    onChanged: (GovernmentIssueID? value) {
                      setState(() {
                        _selectedIDType = value!;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 10,
                    bottom: MediaQuery.of(context).size.width / 10,
                  ),
                  child: getImageWidget(),
                ),

                MaterialButton(
                  color: Colors.green,
                  child: Text(
                    (_selectedFile == null) ? "Take a picture" : "Retake",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     MaterialButton(
                //       color: Colors.green,
                //       child: Text(
                //         "Take a picture",
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       onPressed: () {
                //         getImage(ImageSource.camera);
                //       },
                //     ),
                //     Text(
                //       'or',
                //       style: TextStyle(
                //         fontSize: 19,
                //         color: Colors.white,
                //       ),
                //     ),
                //     MaterialButton(
                //       color: Colors.deepOrange,
                //       child: Text(
                //         "Upload from Device",
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       onPressed: () {
                //         getImage(ImageSource.gallery);
                //       },
                //     ),
                //   ],
                // ),
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
      ),
    );
  }
}
