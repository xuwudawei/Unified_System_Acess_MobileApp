import 'package:flutter/material.dart';

class CameraScreenPage extends StatefulWidget {
  const CameraScreenPage({Key? key}) : super(key: key);

  @override
  _CameraScreenPageState createState() => _CameraScreenPageState();
}

enum Status { RIGHT, LEFT, SMILE, NEUTRAL, EYES_CLOSED, GLASSES }

class _CameraScreenPageState extends State<CameraScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
