import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:usa_app/screens/AccountRegistrationPages/final_face_capturing_page.dart';

class FacesCapturingPage extends StatefulWidget {
  const FacesCapturingPage({Key? key}) : super(key: key);

  @override
  _FacesCapturingPageState createState() => _FacesCapturingPageState();
}

class _FacesCapturingPageState extends State<FacesCapturingPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  bool timeReached = false;
  late CameraController _cameraController;

  final int timerMaxSeconds = 6;
  int currentSeconds = 0;
  final interval = const Duration(seconds: 1);

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController =
        CameraController(front, ResolutionPreset.max, enableAudio: false);
    await _cameraController.initialize();

    setState(() => _isLoading = false);
  }

  _recordVideo([int? milliseconds]) async {
    setState(() {
      _isRecording = true;
    });
    await _cameraController.prepareForVideoRecording();
    await _cameraController.startVideoRecording();
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() async {
        // print(timer.tick);

        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          final file = await _cameraController.stopVideoRecording();
          timer.cancel();
          final route = MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => VideoPage(filePath: file.path),
          );
          Navigator.push(context, route);
          setState(() {
            _isRecording = false;
          });

          // setState(() async {
          //   timeReached = true;
          //   final file = await _cameraController.stopVideoRecording();
          //   setState(() => _isRecording = false);

          // });
        } else {}
      });
    });

    // setState(() => {
    //       _isRecording = true,
    //     });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(_cameraController),
            Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(
                  _isRecording ? Icons.stop : Icons.circle,
                  size: 20,
                ),
                onPressed: () => _recordVideo(),
              ),
            ),
            // Positioned(
            //     child: Text(
            //       timerText,
            //       style: TextStyle(fontSize: 20),
            //     ),
            //     top: 20),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
